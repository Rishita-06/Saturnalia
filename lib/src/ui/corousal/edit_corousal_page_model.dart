import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:Saturnalia/src/logic/services/firebase_storage_service.dart';
import 'package:Saturnalia/src/models/corousal_data.dart';
import '../../logic/repositories/app_repository/app_repository.dart';
import '../../logic/services/firebase_firestore.dart';
import '../../utils/network_utils.dart';
import 'package:uuid/uuid.dart';

part 'edit_corousal_page_model.freezed.dart';

final corousalPageProvider =
    StateNotifierProvider.autoDispose<CorousalPageModel, CorousalPageState>(
  (ref) => CorousalPageModel(
    ref: ref,
    firebaseFirestore: ref.read(firebaseFirestoreProvider),
    firebaseStorageService: ref.read(firebaseStorageServiceProvider),
  ),
);

class CorousalPageModel extends StateNotifier<CorousalPageState> {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorageService firebaseStorageService;
  final AutoDisposeStateNotifierProviderRef ref;
  StreamSubscription? _subscription;
  CorousalPageModel({
    required this.firebaseFirestore,
    required this.ref,
    required this.firebaseStorageService,
  }) : super(const CorousalPageState()) {
    init();
  }

  init() async {
    state = state.copyWith(
      status: CorousalPageStatus.loading,
    );
    await Future.delayed(const Duration(seconds: 1));
    final selectedEvent = ref.watch(
          appRepositoryProvider.select((_) => _.selectedEvent),
        ) ??
        "sat24";
    _subscription = firebaseFirestore
        .collection('corousal')
        .doc(selectedEvent)
        .collection('corousals')
        .snapshots()
        .listen((event) {
      if (event.docs.isNotEmpty) {
        try {
          state = state.copyWith(
            data:
                event.docs.map((e) => CorousalData.fromJson(e.data())).toList(),
            status: CorousalPageStatus.loaded,
          );
        } catch (e) {
          state = state.copyWith(
            data: [],
            status: CorousalPageStatus.error,
          );
        }
      } else {
        state = state.copyWith(
          data: [],
          status: CorousalPageStatus.loaded,
        );
      }
    });
  }

  clearData() {
    state = state.copyWith(
        bannerImageUrl: '',
        corousalType: 0,
        link: null,
        isEditing: false,
        corousalId: null,
        eventId: null);
  }

  addCorousalData(CorousalData? data) {
    if (data != null) {
      state = state.copyWith(
        bannerImageUrl: data.imageUrl,
        corousalType: data.eventId == null ? 0 : 1,
        eventId: data.eventId,
        link: data.link,
        isEditing: true,
        isPublic: data.isPublic ?? false,
        corousalId: data.id,
      );
    } else {
      state = state.copyWith(
        isEditing: false,
      );
    }
  }

  Future<String> pickFile() async {
    XFile? result = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (result != null) {
      File file = File(result.path);
      // debugPrint('file found : ${file.path.toString()}');
      final res = await uploadFile(file);
      return res;
    } else {
      // debugPrint('file not picked');
      return 'File Not Picked';
    }
  }

  Future<String> uploadFile(File file) async {
    if (!await hasInternetAccess()) {
      return 'No Internet Connection';
    }
    state = state.copyWith(uploadStatus: UploadStatus.uploading);

    firebaseStorageService.uploadFile(
      filename: DateTime.now().microsecondsSinceEpoch.toString(),
      file: file,
      onComplete: (storageReference) async {
        try {
          final mediaUrl = await storageReference.getDownloadURL();

          await setBannerUrl(mediaUrl);

          return '';
        } catch (e) {
          return e.toString();
        }
      },
    );
    return '';
  }

  setBannerUrl(String url) async {
    if (state.bannerImageUrl.trim().isNotEmpty) {
      await firebaseStorageService.deleteFile(state.bannerImageUrl);
    }
    state = state.copyWith(
      bannerImageUrl: url,
    );
  }

  setCorousalType(int? type) => state = state.copyWith(
        corousalType: type ?? 0,
      );
  setLink(String link) => state = state.copyWith(
        link: link,
      );
  setEventId(String type) => state = state.copyWith(
        eventId: type,
      );

  Future<String> addCorousal() async {
    if (state.bannerImageUrl.trim().isEmpty) {
      return 'please select corousal image';
    }
    if (state.corousalType == 0) {
      if (state.link == null || state.link!.trim().isEmpty) {
        return 'please enter link';
      }
    } else if (state.corousalType == 1) {
      if (state.eventId == null || state.eventId!.trim().isEmpty) {
        return 'please select eventId';
      }
    }
    if (!(await hasInternetAccess())) {
      return 'No internet connection!';
    }
    const uuid = Uuid();
    final v1 = uuid.v1();
    final selectedEvent = ref.watch(
          appRepositoryProvider.select((_) => _.selectedEvent),
        ) ??
        "sat24";
    try {
      await firebaseFirestore
          .collection('corousal')
          .doc(selectedEvent)
          .collection('corousals')
          .doc('corousal$v1')
          .set(CorousalData(
            id: 'corousal$v1',
            date: DateTime.now(),
            eventId: state.corousalType == 1 ? state.eventId : null,
            imageUrl: state.bannerImageUrl,
            corousalType: state.corousalType,
            isPublic: false,
            link: state.corousalType == 0 ? state.link : null,
          ).toJson());
      return '';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> editCorousal() async {
    if (state.bannerImageUrl.trim().isEmpty) {
      return 'please select corousal image';
    }

    if (state.corousalType == 0) {
      if (state.link == null || state.link!.trim().isEmpty) {
        return 'please enter link';
      }
    } else if (state.corousalType == 1) {
      if (state.eventId == null || state.eventId!.trim().isEmpty) {
        return 'please select eventId';
      }
    }
    if (!(await hasInternetAccess())) {
      return 'No internet connection!';
    }
    final selectedEvent = ref.watch(
          appRepositoryProvider.select((_) => _.selectedEvent),
        ) ??
        "sat24";
    try {
      await firebaseFirestore
          .collection('corousal')
          .doc(selectedEvent)
          .collection('corousals')
          .doc(state.corousalId)
          .update(CorousalData(
                  id: state.corousalId!,
                  date: DateTime.now(),
                  eventId: state.corousalType == 1 ? state.eventId : null,
                  imageUrl: state.bannerImageUrl,
                  corousalType: state.corousalType,
                  isPublic: state.isPublic,
                  link: state.corousalType == 0 ? state.link : null)
              .toJson());
      return '';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> updateCorousalVisibility(bool isVisible, String id) async {
    if (!(await hasInternetAccess())) {
      return 'No internet connection!';
    }
    try {
      final selectedEvent = ref.watch(
            appRepositoryProvider.select((_) => _.selectedEvent),
          ) ??
          "sat24";
      await firebaseFirestore
          .collection('corousal')
          .doc(selectedEvent)
          .collection('corousals')
          .doc(id)
          .update({
        "isPublic": isVisible,
      });

      return '';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> deleteCorousal(String id) async {
    if (!(await hasInternetAccess())) {
      return 'No internet connection!';
    }
    try {
      final selectedEvent = ref.watch(
            appRepositoryProvider.select((_) => _.selectedEvent),
          ) ??
          "sat24";
      if (state.bannerImageUrl.trim().isNotEmpty) {
        await firebaseStorageService.deleteFile(state.bannerImageUrl);
      }
      await firebaseFirestore
          .collection('corousal')
          .doc(selectedEvent)
          .collection('corousal')
          .doc(id)
          .delete();

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
class CorousalPageState with _$CorousalPageState {
  const factory CorousalPageState({
    @Default(CorousalPageStatus.initial) CorousalPageStatus status,
    @Default(UploadStatus.initial) UploadStatus uploadStatus,
    @Default(null) List<CorousalData>? data,
    @Default('') String bannerImageUrl,
    @Default(null) String? link,
    @Default(null) String? corousalId,
    @Default(false) bool isEditing,
    @Default(false) bool isPublic,
    @Default(0) int corousalType,
    @Default(null) String? eventId,
  }) = _CorousalPageState;
}

enum CorousalPageStatus {
  initial,
  loading,
  loaded,
  error,
}

enum UploadStatus {
  initial,
  uploading,
  uploaded,
  error,
}
