import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:Saturnalia/src/models/reward_points_data.dart';

import 'package:uuid/uuid.dart';

import '../../logic/services/firebase_firestore.dart';

import '../../logic/repositories/app_repository/app_repository.dart';
import '../../models/event_user_data.dart';
import '../../utils/network_utils.dart';
import '../../utils/project_utils.dart';

part 'event_page_model.freezed.dart';

final eventPageProvider =
    StateNotifierProvider.autoDispose<EventPageModel, EventPageState>(
  (ref) => EventPageModel(
    firebaseFirestore: ref.read(firebaseFirestoreProvider),
    ref: ref,
  ),
);

class EventPageModel extends StateNotifier<EventPageState> {
  final FirebaseFirestore firebaseFirestore;
  StreamSubscription? _subscription;
  StreamSubscription? _subscription2;
  final AutoDisposeStateNotifierProviderRef ref;
  EventPageModel({
    required this.firebaseFirestore,
    required this.ref,
  }) : super(const EventPageState());
  init() {
    state = state.copyWith(
      isPreview: true,
      status: EventStatus.notRegistered,
    );
  }

  getEventUserData(String eventId, String eventName) async {
    state = state.copyWith(
      eventName: eventName,
      status: EventStatus.loading,
      eventId: eventId,
    );

    await Future.delayed(const Duration(milliseconds: 500));

    try {
      if (!(await hasInternetAccess())) {
        state = state.copyWith(
          status: EventStatus.error,
        );
        return;
      }
      final userId = ref.read(
        appRepositoryProvider.select((_) => _.userData?.userId),
      );
      final res = await checkUserUniqueId();
      if (res != '') {
        debugPrint(res);
        state = state.copyWith(
          status: EventStatus.error,
        );
        return;
      }
      final selectedEvent = ref.watch(
            appRepositoryProvider.select((_) => _.selectedEvent),
          ) ??
          "sat24";
      _subscription = firebaseFirestore
          .collection('event')
          .doc(selectedEvent)
          .collection('events')
          .doc(eventId)
          .collection('users')
          .where('userId', isEqualTo: userId)
          .snapshots()
          .listen((documents) async {
        if (documents.docs.isNotEmpty) {
          for (var doc in documents.docs) {
            if (doc.exists) {
              if (doc.data()["userId"] == userId) {
                state = state.copyWith(
                  data: EventUserData.fromJson(doc.data()),
                );
                break;
              }
            }
          }

          state = state.copyWith(
            status: state.data == null
                ? EventStatus.notRegistered
                : state.data?.isVerified == null
                    ? EventStatus.regiesteredNotVerified
                    : state.data!.isVerified
                        ? EventStatus.verified
                        : EventStatus.regiesteredNotVerified,
            isAttending: state.data == null ? false : state.data!.isAttending,
          );
        } else {
          state = state.copyWith(
            status: EventStatus.notRegistered,
            isAttending: false,
          );
        }
      });
    } catch (e) {
      state = state.copyWith(status: EventStatus.error);
    }
  }

  updateAttendingStatus(
    bool isAttending,
  ) {
    state = state.copyWith(
      isAttending: isAttending,
    );
  }

  Future<String> checkUserUniqueId() async {
    try {
      final userId = ref.read(
            appRepositoryProvider.select((_) => _.userData?.userId),
          ) ??
          '';
      if (!await hasInternetAccess()) {
        return '2';
      }
      if (userId.trim().isEmpty) {
        return 'Something Went Wrong';
      }
      final res = await firebaseFirestore.collection('users').doc(userId).get();
      if (!((res.data()!['eventUniqueIds'] as List?) ?? []).contains(
          '${state.eventId}-${generateReferralCode(state.eventId.substring(0, 10) + userId.substring(0, 15), false)}')) {
        await firebaseFirestore.collection('users').doc(userId).update({
          'eventUniqueIds': ((res.data()!['eventUniqueIds'] as List?) ?? [])
            ..add(
                '${state.eventId}-${generateReferralCode(state.eventId.substring(0, 10) + userId.substring(0, 15), false)}')
        });
      }
      return '';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> updateStatus(String tokeId) async {
    if (!await hasInternetAccess()) {
      return 'No Internet Connection!';
    } else {
      try {
        final selectedEvent = ref.watch(
              appRepositoryProvider.select((_) => _.selectedEvent),
            ) ??
            "sat24";
        await firebaseFirestore
            .collection('event')
            .doc(selectedEvent)
            .collection('events')
            .doc(state.eventId)
            .collection('users')
            .doc(tokeId)
            .update(
          {
            'isAttending': state.isAttending,
          },
        );
        return '';
      } catch (e) {
        return e.toString();
      }
    }
  }

  Future<String> registerForEvents() async {
    final userData = ref.read(
      appRepositoryProvider.select((_) => _.userData),
    );
    final userEmail = ref.read(
      appRepositoryProvider.select((_) => _.userData?.email),
    );
    final userName = ref.read(
      appRepositoryProvider.select(
        (_) => _.userData?.userName,
      ),
    );
    if (state.eventId == '') {
      return 'Something Went Wrong';
    }

    if (userData?.userId == null || userEmail == null) {
      return 'User is unauthenticated';
    }

    if (!await hasInternetAccess()) {
      return 'No Internet Connection';
    }
    const uuid = Uuid();
    final v1 = uuid.v1();
    try {
      final selectedEvent = ref.watch(
            appRepositoryProvider.select((_) => _.selectedEvent),
          ) ??
          "sat24";
      await firebaseFirestore
          .collection('event')
          .doc(selectedEvent)
          .collection('events')
          .doc(state.eventId)
          .collection('users')
          .doc(v1)
          .set(
        {
          'userId': userData!.userId,
          'isVerified': false,
          'tokenId': v1,
          'name': userName,
          'collegeAddress':
              '${userData.collegeName} ${userData.collegeCity} ${userData.collegeState}, ${userData.collegePinCode}',
          'mobile': userData.phoneNumber,
          'userEmail': userData.email,
          'verificationTime': null,
          'isAttending': state.isAttending,
          'isParticipant': false,
        },
      );
      await firebaseFirestore.collection('users').doc(userData.userId).update(
        {
          'events': (userData.events?.toList() ?? [])
            ..removeWhere((e) => e == state.eventId)
            ..add(state.eventId),
        },
      );
      await firebaseFirestore
          .collection('users')
          .doc(userData.userId)
          .collection('rewards')
          .doc('register${state.eventId}')
          .set(
            RewardPointsData(
              date: DateTime.now(),
              message: 'Pending',
              id: 'register${state.eventId}',
              coins: 40,
              isAwarded: 0,
              title: '${state.eventName}(Registration)',
            ).toJson(),
          );

      return '';
    } catch (e) {
      return e.toString();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _subscription2?.cancel();
    _subscription?.cancel();
  }
}

@freezed
class EventPageState with _$EventPageState {
  const factory EventPageState({
    @Default(0) int userBalance,
    @Default(null) EventUserData? data,
    @Default('') String eventId,
    @Default(true) bool isAttending,
    @Default('') String eventName,
    @Default(false) bool isPreview,
    @Default(EventStatus.initial) EventStatus status,
  }) = _EventPageState;
}

enum EventStatus {
  initial,
  loading,
  notRegistered,
  regiesteredNotVerified,
  verified,
  error,
}
