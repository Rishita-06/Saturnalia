import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:Saturnalia/src/logic/repositories/app_repository/app_repository.dart';
import 'package:Saturnalia/src/logic/services/preference_service.dart';
import '../../logic/services/firebase_firestore.dart';
import '../../models/notification_data.dart';

part 'notification_page_model.freezed.dart';

final notificationPageProvider = StateNotifierProvider.autoDispose<
    NotificationPageModel, NotificationPageState>(
  (ref) => NotificationPageModel(
    firebaseFirestore: ref.read(firebaseFirestoreProvider),
    preferenceServiceProvider: ref.read(preferenceServiceProvider),
    ref: ref,
  ),
);

class NotificationPageModel extends StateNotifier<NotificationPageState> {
  final FirebaseFirestore firebaseFirestore;
  StreamSubscription? subscription;
  final PreferenceService preferenceServiceProvider;
  final AutoDisposeStateNotifierProviderRef ref;
  NotificationPageModel({
    required this.firebaseFirestore,
    required this.preferenceServiceProvider,
    required this.ref,
  }) : super(const NotificationPageState()) {
    getNotifications();
    getNotifcationsIds();
  }
  getNotifications() {
    subscription = firebaseFirestore
        .collection('notifications')
        .orderBy('id', descending: true)
        .snapshots()
        .listen((event) {
      if (event.docs.isNotEmpty) {
        state = state.copyWith(
            notificationData: event.docs
                .map(
                  (e) => NotificationData.fromJson(
                    e.data(),
                  ),
                )
                .toList());
      }
    });
  }

  getNotifcationsIds() async {
    final userId =
        ref.read(appRepositoryProvider.select((_) => _.userData?.userId));
    final data = preferenceServiceProvider
        .getString('${PreferenceService.notifcationList}$userId');

    state = state.copyWith(readNotificationList: data ?? '');
  }

  markAllasRead() async {
    String lists = '';
    for (int i = 0; i < state.notificationData.length; i++) {
      lists = '$lists-${state.notificationData[i].id}';
    }
    final userId =
        ref.read(appRepositoryProvider.select((_) => _.userData?.userId));
    await preferenceServiceProvider.setString(
      '${PreferenceService.notifcationList}$userId',
      lists,
    );
    getNotifcationsIds();
  }

  markNotificationAsRead(String id) async {
    final userId =
        ref.read(appRepositoryProvider.select((_) => _.userData?.userId));

    await preferenceServiceProvider.setString(
      '${PreferenceService.notifcationList}$userId',
      '${state.readNotificationList}-$id',
    );
    getNotifcationsIds();
  }
}

@freezed
class NotificationPageState with _$NotificationPageState {
  const factory NotificationPageState({
    @Default([]) List<NotificationData> notificationData,
    @Default('') String readNotificationList,
  }) = _NotificationPageState;
}
