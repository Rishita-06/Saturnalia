import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:Saturnalia/src/models/team_data.dart';
import 'package:Saturnalia/src/utils/network_utils.dart';
import '../../logic/services/firebase_firestore.dart';

part 'manage_team_page_model.freezed.dart';

final manageTeamPageProvider =
    StateNotifierProvider.autoDispose<ManageTeamModel, ManageTeamState>(
  (ref) => ManageTeamModel(
    firebaseFirestore: ref.read(firebaseFirestoreProvider),
  ),
);

class ManageTeamModel extends StateNotifier<ManageTeamState> {
  final FirebaseFirestore firebaseFirestore;
  StreamSubscription? _subscription;
  ManageTeamModel({required this.firebaseFirestore})
      : super(const ManageTeamState()) {
    init();
  }
  init() async {
    state = state.copyWith(
      status: ManageTeamStatus.loading,
    );
    await Future.delayed(const Duration(milliseconds: 500));
    if (!await hasInternetAccess()) {
      state = state.copyWith(
        status: ManageTeamStatus.error,
      );
      return;
    }
    _subscription = firebaseFirestore
        .collection('users')
        .where('roleId', isNotEqualTo: 2)
        .snapshots()
        .listen((event) {
      if (event.docs.isNotEmpty) {
        state = state.copyWith(
          team: event.docs.map((e) => TeamData.fromJson(e.data())).toList(),
          status: ManageTeamStatus.loaded,
        );
      }
    }, onError: (_) {
      state = state.copyWith(
        status: ManageTeamStatus.error,
      );
    });
  }

  Future<TeamData?> searchMember(String email) async {
    if (email.trim().contains('@')) {
      if (!(email.trim().split('@')[1] == 'thapar.edu' ||
          email.trim().split('@')[1] == 'gmail.com')) {
        return null;
      }
    } else {
      return null;
    }
    final data = await firebaseFirestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    if (data.docs.isNotEmpty) {
      return TeamData.fromJson(data.docs.first.data());
    }
    return null;
  }

  Future<String> updateRoleId(int id, String userId) async {
    if (!(await hasInternetAccess())) {
      return 'No internet connection!';
    }
    await Future.delayed(const Duration(seconds: 1));
    try {
      await firebaseFirestore.collection('users').doc(userId).update(
        {
          "roleId": id,
        },
      );
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
class ManageTeamState with _$ManageTeamState {
  const factory ManageTeamState({
    @Default(ManageTeamStatus.initial) ManageTeamStatus status,
    @Default(null) List<TeamData>? team,
  }) = _ManageTeamState;
}

enum ManageTeamStatus {
  initial,
  loading,
  loaded,
  error,
}
