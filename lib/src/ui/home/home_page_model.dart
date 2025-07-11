import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:Saturnalia/src/models/corousal_data.dart';

import '../../logic/repositories/app_repository/app_repository.dart';
import '../../logic/services/firebase_firestore.dart';

part 'home_page_model.freezed.dart';

final homePageProvider =
    StateNotifierProvider.autoDispose<HomePageModel, HomePageState>(
  (ref) => HomePageModel(
    firebaseFirestore: ref.read(firebaseFirestoreProvider),
    ref: ref,
  ),
);

class HomePageModel extends StateNotifier<HomePageState> {
  final FirebaseFirestore firebaseFirestore;
  final AutoDisposeStateNotifierProviderRef ref;
  StreamSubscription? _subscription;
  StreamSubscription? _subscription2;
  HomePageModel({
    required this.firebaseFirestore,
    required this.ref,
  }) : super(const HomePageState()) {
    init();
  }
  init() {
    state = state.copyWith(
      status: HomePageStatus.loading,
    );
    final selectedEvent = ref.watch(
          appRepositoryProvider.select((_) => _.selectedEvent),
        ) ??
        "sat24";
    _subscription = firebaseFirestore
        .collection('corousal')
        .doc(selectedEvent)
        .collection('corousals')
        .where('isPublic', isEqualTo: true)
        .snapshots()
        .listen((event) {
      if (event.docs.isNotEmpty) {
        state = state.copyWith(
          status: HomePageStatus.loaded,
          corousalList: event.docs
              .map(
                (e) => CorousalData.fromJson(
                  e.data(),
                ),
              )
              .toList(),
        );
      } else {
        state = state.copyWith(
          corousalList: [],
          status: HomePageStatus.loaded,
        );
      }
    });
  }

  setFilterTag(String tag) => state = state.copyWith(
        tag: tag,
      );
  @override
  void dispose() {
    _subscription?.cancel();
    _subscription2?.cancel();
    super.dispose();
  }
}

@freezed
class HomePageState with _$HomePageState {
  const factory HomePageState({
    @Default(HomePageStatus.initial) HomePageStatus status,
    @Default(null) List<CorousalData>? corousalList,
    @Default('all') String tag,
  }) = _HomePageState;
}

enum HomePageStatus {
  initial,
  loading,
  loaded,
  error,
}
