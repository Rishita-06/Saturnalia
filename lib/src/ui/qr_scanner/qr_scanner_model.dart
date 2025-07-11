import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:Saturnalia/src/logic/repositories/app_repository/app_repository.dart';

import '../../logic/services/firebase_firestore.dart';
import '../../models/event_user_data.dart';
import '../../models/reward_points_data.dart';
import '../../utils/network_utils.dart';

part 'qr_scanner_model.freezed.dart';

final qrScannerPageProvider =
    StateNotifierProvider.autoDispose<QrScannerPageModel, QrScannerPageState>(
  (ref) => QrScannerPageModel(
    firebaseFirestore: ref.read(firebaseFirestoreProvider),
    ref: ref,
  ),
);

class QrScannerPageModel extends StateNotifier<QrScannerPageState> {
  final FirebaseFirestore firebaseFirestore;
  final AutoDisposeStateNotifierProviderRef ref;
  QrScannerPageModel({
    required this.firebaseFirestore,
    required this.ref,
  }) : super(const QrScannerPageState());

  setEventId(String eventId, String eventName) {
    state = state.copyWith(
      eventId: eventId,
      eventName: eventName,
    );
  }

  Future<void> processQr(String? token) async {
    if (token == '' || token == null) {
      state = state.copyWith(
        status: QrStatus.wrongQr,
        errorMesaage: "Wrong Qr Code",
      );
      return;
    }
    if (!await hasInternetAccess()) {
      state = state.copyWith(
        status: QrStatus.error,
        errorMesaage: "No Inernet Connection",
      );
      return;
    }
    try {
      final adminData = ref.watch(
        appRepositoryProvider.select(
          (_) => _.userData,
        ),
      );
      final selectedEvent = ref.watch(
            appRepositoryProvider.select((_) => _.selectedEvent),
          ) ??
          "sat24";
      state = state.copyWith(status: QrStatus.processing);
      final res = await firebaseFirestore
          .collection('event')
          .doc(selectedEvent)
          .collection('events')
          .doc(state.eventId)
          .collection('users')
          .doc(token)
          .get();
      late final EventUserData data;
      if (res.exists) {
        data = EventUserData.fromJson(res.data()!);
        if (data.isVerified) {
          state = state.copyWith(
            status: QrStatus.processedAlreadyVerified,
            data: data,
          );
          return;
        }
        state = state.copyWith(
          data: data,
        );
      } else {
        state = state.copyWith(
          status: QrStatus.wrongQr,
          errorMesaage: "Wrong Qr Code",
        );
        return;
      }
      await firebaseFirestore
          .collection('event')
          .doc(selectedEvent)
          .collection('events')
          .doc(state.eventId)
          .collection('users')
          .doc(token)
          .update({
        "isVerified": true,
        "verificationTime": DateTime.now(),
        'verifiedBy': adminData!.userName,
        'email': adminData.email,
      });
      state = state.copyWith(
        status: QrStatus.processedAndVerified,
        data: data,
      );
      await firebaseFirestore
          .collection('users')
          .doc(data.userId)
          .collection('rewards')
          .doc('register${state.eventId}')
          .update({
        'message': 'Done',
        'isAwarded': 1,
      });
      await firebaseFirestore
          .collection('users')
          .doc(data.userId)
          .collection('rewards')
          .doc('scan${state.eventId}')
          .set(
            RewardPointsData(
              date: DateTime.now(),
              message: 'Scanned',
              id: 'scan${state.eventId}',
              coins: 40,
              isAwarded: 1,
              title: '${state.eventName}(Scan)',
            ).toJson(),
          );

      return;
    } catch (e) {
      // debugPrint('error:${e.toString()}');
      state = state.copyWith(
        status: QrStatus.error,
      );
    }
  }

  setStatus(QrStatus status) {
    state = state.copyWith(
      status: status,
      data: null,
      errorMesaage: 'Something Went Wrong',
    );
  }
}

@freezed
class QrScannerPageState with _$QrScannerPageState {
  const factory QrScannerPageState({
    @Default(null) String? eventId,
    @Default(null) String? eventName,
    @Default(QrStatus.initial) QrStatus status,
    @Default(null) EventUserData? data,
    @Default(null) String? errorMesaage,
  }) = _QrScannerPageState;
}

enum QrStatus {
  initial,
  processing,
  processedAndVerified,
  processedAlreadyVerified,
  wrongQr,
  error,
}
