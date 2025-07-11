import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../logic/repositories/app_repository/app_repository.dart';
import '../../logic/services/firebase_firestore.dart';
import '../../utils/network_utils.dart';

part 'manage_event_page_model.freezed.dart';

final manageEventPageProvider = StateNotifierProvider.autoDispose<
    ManageEventPageModel, ManageEventPageState>(
  (ref) => ManageEventPageModel(
    firebaseFirestore: ref.read(firebaseFirestoreProvider),
    ref: ref,
  ),
);

class ManageEventPageModel extends StateNotifier<ManageEventPageState> {
  final FirebaseFirestore firebaseFirestore;
  final AutoDisposeStateNotifierProviderRef ref;
  // StreamSubscription? _subscription;
  ManageEventPageModel({
    required this.firebaseFirestore,
    required this.ref,
  }) : super(const ManageEventPageState());

  Future<String> updateEventVisibility(
      String eventId, bool isPublic, int roleId) async {
    if (roleId != 0) {
      return 'You don\'t have access';
    }
    if (!await hasInternetAccess()) {
      return 'No Internet Connection!';
    }
    try {
      final selectedEvent = ref.watch(
            appRepositoryProvider.select((_) => _.selectedEvent),
          ) ??
          "sat24";
      await firebaseFirestore
          .collection('event')
          .doc(selectedEvent)
          .collection('events')
          .doc(eventId)
          .update(
        {
          "isPublic": isPublic,
        },
      );
      return '';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> updateEventScanner(
      String eventId, bool isStarted, int roleId) async {
    if (roleId != 0) {
      return 'You don\'t have acsess';
    }

    if (!await hasInternetAccess()) {
      return 'No Internet Connection!';
    }

    try {
      final selectedEvent = ref.watch(
            appRepositoryProvider.select((_) => _.selectedEvent),
          ) ??
          "sat24";
      await firebaseFirestore
          .collection('event')
          .doc(selectedEvent)
          .collection('events')
          .doc(eventId)
          .update(
        {
          "details.scanningStarted": isStarted,
        },
      );
      return '';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> updateFeatured(String eventId, bool isStarted) async {
    // if (roleId != 0) {
    //   return 'You don\'t have acsess';
    // }

    if (!await hasInternetAccess()) {
      return 'No Internet Connection!';
    }

    try {
      final selectedEvent = ref.watch(
            appRepositoryProvider.select((_) => _.selectedEvent),
          ) ??
          "sat24";
      await firebaseFirestore
          .collection('event')
          .doc(selectedEvent)
          .collection('events')
          .doc(eventId)
          .update(
        {
          "isFeatured": isStarted,
        },
      );
      return '';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> deleteEvent(String eventId) async {
    if (!await hasInternetAccess()) {
      return 'No Internet Connection!';
    }
    try {
      final selectedEvent = ref.watch(
            appRepositoryProvider.select((_) => _.selectedEvent),
          ) ??
          "sat24";
      await firebaseFirestore
          .collection('event')
          .doc(selectedEvent)
          .collection('events')
          .doc(eventId)
          .delete();
      return '';
    } catch (e) {
      return e.toString();
    }
  }
}

@freezed
class ManageEventPageState with _$ManageEventPageState {
  const factory ManageEventPageState({
    @Default(ManageEventPageStatus.initial) ManageEventPageStatus status,
  }) = _ManageEventPageState;
}

enum ManageEventPageStatus {
  initial,
  loading,
  loaded,
  error,
}
