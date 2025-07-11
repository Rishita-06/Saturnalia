import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:Saturnalia/src/utils/network_utils.dart';
import '../../logic/repositories/app_repository/app_repository.dart';
import '../../logic/services/firebase_firestore.dart';
import '../../models/poll_data.dart';
import '../../models/reward_points_data.dart';

part 'poll_page_model.freezed.dart';

final pollPageProvider =
    StateNotifierProvider.autoDispose<PollPageModel, PollPageState>(
  (ref) => PollPageModel(
    firebaseFirestore: ref.read(firebaseFirestoreProvider),
    ref: ref,
  ),
);

class PollPageModel extends StateNotifier<PollPageState> {
  final FirebaseFirestore firebaseFirestore;
  final AutoDisposeStateNotifierProviderRef ref;
  StreamSubscription? _subscription;
  PollPageModel({
    required this.firebaseFirestore,
    required this.ref,
  }) : super(const PollPageState()) {
    init();
  }
  init() async {
    state = state.copyWith(
      status: PollPageStatus.loading,
    );
    await Future.delayed(const Duration(milliseconds: 500));
    if (!await hasInternetAccess()) {
      state = state.copyWith(
        status: PollPageStatus.noInternet,
      );
      return;
    }
    _subscription = firebaseFirestore
        .collection('polls')
        .orderBy('creationTime', descending: true)
        .snapshots()
        .listen((event) {
      if (event.docs.isNotEmpty) {
        try {
          state = state.copyWith(
            polls: event.docs.map((e) => PollData.fromJson(e.data())).toList(),
            status: PollPageStatus.loaded,
          );
        } catch (e) {
          debugPrint(e.toString());
          state = state.copyWith(
            status: PollPageStatus.error,
          );
        }
      }
    }, onError: (_) {
      state = state.copyWith(
        status: PollPageStatus.error,
      );
    });
  }

  Future<String> addVote(String id, String option, int coin) async {
    final userId = ref.read(
      appRepositoryProvider.select((_) => _.userData?.userId),
    );
    if (!await hasInternetAccess()) {
      return 'No Internet Connection!';
    }
    try {
      await firebaseFirestore
          .collection('polls')
          .doc(id)
          .collection('users')
          .doc(userId)
          .set({'option': option});
      if (coin != 0) {
        await firebaseFirestore
            .collection('users')
            .doc(userId)
            .collection('rewards')
            .doc('poll-$id')
            .set(
              RewardPointsData(
                date: DateTime.now(),
                message: 'Done',
                id: 'poll-$id',
                coins: coin,
                isAwarded: 1,
                title: 'Reward for voting in a poll',
              ).toJson(),
            );
      }
      return '';
    } catch (e) {
      return e.toString();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }
}

@freezed
class PollPageState with _$PollPageState {
  const factory PollPageState({
    @Default(PollPageStatus.initial) PollPageStatus status,
    @Default(null) List<PollData>? polls,
  }) = _PollPageState;
}

enum PollPageStatus {
  initial,
  loading,
  noInternet,
  loaded,
  error,
}
