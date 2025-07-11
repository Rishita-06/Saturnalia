import 'dart:async';

import 'package:Saturnalia/src/models/contact_us_data.dart';
import 'package:Saturnalia/src/utils/network_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../logic/repositories/app_repository/app_repository.dart';
import '../../logic/services/firebase_firestore.dart';

part 'contact_us_model.freezed.dart';

final contactUsPageProvider =
    StateNotifierProvider.autoDispose<ContactUsPageModel, ContactUsPageState>(
  (ref) => ContactUsPageModel(
    firebaseFirestore: ref.read(firebaseFirestoreProvider),
    ref: ref,
  ),
);

class ContactUsPageModel extends StateNotifier<ContactUsPageState> {
  final FirebaseFirestore firebaseFirestore;
  final AutoDisposeStateNotifierProviderRef ref;
  StreamSubscription? _subscription;
  ContactUsPageModel({
    required this.firebaseFirestore,
    required this.ref,
  }) : super(const ContactUsPageState()) {
    init();
  }
  init() async {
    state = state.copyWith(
      status: ContactUsPageStatus.loading,
    );
    final userId = ref.read(
      appRepositoryProvider.select((_) => _.userData?.userId ?? ''),
    );
    if (userId == '') {
      state = state.copyWith(
        status: ContactUsPageStatus.error,
      );
      return;
    }
    if (!await hasInternetAccess()) {
      state = state.copyWith(
        status: ContactUsPageStatus.noInternet,
      );
      return;
    }
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      final res = await firebaseFirestore
          .collection('queries')
          .where('userId', isEqualTo: userId)
          .orderBy('time', descending: true)
          .get();

      if (res.docs.isNotEmpty) {

        final data = res.docs.map((e) => ContactUsData.fromJson(e.data()));
        state=state.copyWith(data:data.first);
        if (data.first.time
                .compareTo(DateTime.now().subtract(const Duration(days: 1))) >
            0) {
          state = state.copyWith(
            status: ContactUsPageStatus.loadedAndPendingQuery,
          );
        } else {
          state = state.copyWith(
            status: ContactUsPageStatus.loaded,
          );
        }
      } else {
        state = state.copyWith(
          status: ContactUsPageStatus.loaded,
        );
      }
    }
  }

  Future<String> sendQuery() async {
    if (state.issueTitle == null) {
      return 'please select your query type';
    }
    if (state.description.trim().isEmpty) {
      return 'Please enter your query';
    }
    final userData =
        ref.read(appRepositoryProvider.select((value) => value.userData));
    if (userData?.userId == null) {
      return 'Something Went Wrong';
    }
    try {
      await firebaseFirestore.collection('queries').add(ContactUsData(
            userId: userData!.userId,
            userName: userData.userName,
            email: userData.email,
            eventId: state.issueTitle!,
            mobile: userData.phoneNumber,
            description: state.description,
            time: DateTime.now(),

          ).toJson());
      init();
      return '';
    } catch (e) {
      init();
      return e.toString();
    }
  }

  setDescription(String desc) {
    state = state.copyWith(description: desc);
  }

  setQuery(String query) {
    state = state.copyWith(issueTitle: query);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

@freezed
class ContactUsPageState with _$ContactUsPageState {
  const factory ContactUsPageState({
    @Default(ContactUsPageStatus.initial) ContactUsPageStatus status,
    @Default(null) String? issueTitle,
    @Default(null) ContactUsData? data,
    @Default('') String description,
  }) = _ContactUsPageState;
}

enum ContactUsPageStatus {
  initial,
  loading,
  loadedAndPendingQuery,
  loaded,
  noInternet,
  error,
}
