import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:Saturnalia/src/logic/repositories/app_repository/app_repository.dart';
import 'package:Saturnalia/src/models/reward_data.dart';
import 'package:Saturnalia/src/models/reward_points_data.dart';

import '../../services/firebase_firestore.dart';

part 'store_repository.freezed.dart';

final storeRepositoryProvider =
    StateNotifierProvider.autoDispose<StorePageModel, StorePageState>(
  (ref) => StorePageModel(
    firebaseFirestore: ref.read(firebaseFirestoreProvider),
    ref: ref,
  ),
);

class StorePageModel extends StateNotifier<StorePageState> {
  final FirebaseFirestore firebaseFirestore;
  StreamSubscription? _subscription;
  StreamSubscription? _subscription2;
  StreamSubscription? _subscription3;
  final AutoDisposeStateNotifierProviderRef ref;
  StorePageModel({
    required this.firebaseFirestore,
    required this.ref,
  }) : super(const StorePageState()) {
    getUserRewardsList();
  }
  getUserRewardsList() async {
    state = state.copyWith(
      status: StorePageStatus.loading,
    );

    final userId =
        ref.read(appRepositoryProvider.select((_) => _.userData?.userId ?? ''));
    try {
      _subscription = firebaseFirestore
          .collection('users')
          .doc(userId)
          .collection('rewards')
          .orderBy(
            'date',
            descending: true,
          )
          .snapshots()
          .listen((rewards) {
        if (rewards.docs.isNotEmpty) {
          state = state.copyWith(
            rewards: rewards.docs
                .map((e) => RewardPointsData.fromJson(e.data()))
                .toList(),
          );
        }
        int totalCoins = getTotalCoins(state.rewards ?? []);
        final userCoins =
            ref.read(appRepositoryProvider.select((_) => _.userData?.coins)) ??
                0;

        if (userCoins != totalCoins) {
          firebaseFirestore
              .collection('users')
              .doc(userId)
              .update({"coins": totalCoins});
        }
      }, onError: (error) {
        state = state.copyWith(
          status: StorePageStatus.error,
        );
      });
    } catch (e) {
      state = state.copyWith(
        status: StorePageStatus.error,
      );
    }
    getReedemCount();
    getRewardsList();
  }

  getRewardsList() {
    _subscription2 =
        firebaseFirestore.collection('rewards').snapshots().listen((event) {
      if (event.docs.isNotEmpty) {
        state = state.copyWith(
          rewardsList:
              event.docs.map((e) => RewardData.fromJson(e.data())).toList(),
          publicRewardsList: event.docs
              .map((e) => RewardData.fromJson(e.data()))
              .toList()
              .where((element) => element.isPublic)
              .toList(),
          status: StorePageStatus.loaded,
        );
      } else {
        state = state.copyWith(
          rewardsList: [],
          publicRewardsList: [],
          status: StorePageStatus.loaded,
        );
      }
    }, onError: (_) {
      state = state.copyWith(
        status: StorePageStatus.error,
      );
    });
  }

  int getTotalCoins(List<RewardPointsData> data) {
    if (data.isEmpty) {
      return 0;
    }
    int coins = 0;
    for (RewardPointsData reward in data) {
      if (reward.isAwarded == 0) {
      } else if (reward.isAwarded == 1) {
        coins += reward.coins;
      } else {
        coins -= reward.coins;
      }
    }
    return coins;
  }

  getReedemCount() {
    final userId =
        ref.read(appRepositoryProvider.select((_) => _.userData?.userId ?? ''));
    _subscription3 = firebaseFirestore
        .collection('reedems')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .listen((event) {
      state = state.copyWith(
        itemCount: event.docs.length,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
    _subscription2?.cancel();
    _subscription3?.cancel();
  }
}

@freezed
class StorePageState with _$StorePageState {
  const factory StorePageState({
    @Default(null) List<RewardPointsData>? rewards,
    @Default(null) List<RewardData>? rewardsList,
    @Default(null) List<RewardData>? publicRewardsList,
    @Default(0) int itemCount,
    @Default(StorePageStatus.initial) StorePageStatus status,
  }) = _StorePageState;
}

enum StorePageStatus {
  initial,
  loading,
  loaded,
  error,
}
