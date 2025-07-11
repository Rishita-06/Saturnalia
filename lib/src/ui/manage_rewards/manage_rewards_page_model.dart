import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:uuid/uuid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:Saturnalia/src/logic/services/firebase_storage_service.dart';
import 'package:Saturnalia/src/models/reward_data.dart';

import '../../logic/services/firebase_firestore.dart';
import '../../utils/network_utils.dart';

part 'manage_rewards_page_model.freezed.dart';

final manageRewardsPageProvider = StateNotifierProvider.autoDispose<
    ManageRewardsPageModel, ManageRewardsPageState>(
  (ref) => ManageRewardsPageModel(
    firebaseFirestore: ref.read(firebaseFirestoreProvider),
    firebaseStorageService: ref.read(firebaseStorageServiceProvider),
  ),
);

class ManageRewardsPageModel extends StateNotifier<ManageRewardsPageState> {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorageService firebaseStorageService;
  StreamSubscription? _subscription;
  ManageRewardsPageModel({
    required this.firebaseFirestore,
    required this.firebaseStorageService,
  }) : super(const ManageRewardsPageState()) {
    state = state.copyWith(status: ManageRewardsPageStatus.loaded);
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
    if (state.imageUrl.trim().isNotEmpty) {
      await firebaseStorageService.deleteFile(state.imageUrl);
    }
    state = state.copyWith(
      imageUrl: url,
    );
  }

  setRewardName(String name) => state = state.copyWith(
        title: name,
      );
  setDescription(String desc) => state = state.copyWith(
        description: desc,
      );
  setCoin(int coin) => state = state.copyWith(
        coins: coin,
      );
  setQuantity(int quantity) => state = state.copyWith(
        itemLeft: quantity,
      );
  setOriginalValue(int value) => state = state.copyWith(
        originalValue: value,
      );
  setValidTillDate(DateTime? date) => state = state.copyWith(
        validTill: date,
      );
  setOfferCoins(int value) => state = state.copyWith(
        offerCoins: value,
      );
  setRewardType(bool isExclusive) => state = state.copyWith(
        isExclusive: isExclusive,
      );
  Future<String> addReward() async {
    if (state.imageUrl.trim().isEmpty) {
      return 'Please add image';
    }
    if (state.title.trim().isEmpty) {
      return 'Please add reward name';
    }
    if (state.coins == null) {
      return 'Please enter reward coin';
    }
    if (state.coins == 0) {
      return 'please enter valid coin value';
    }
    if (state.itemLeft == 0) {
      return 'please enter quantity';
    }
    if (state.originalValue == null) {
      return 'please enter original reward value';
    }
    if (state.originalValue == 0) {
      return 'please enter valid reward value';
    }
    if (state.validTill == null) {
      return 'please enter redeem last date';
    }
    if (state.isExclusive) {
      if (state.offerCoins == null || state.offerCoins == 0) {
        return 'please enter offer coin';
      }
    }
    if (!await hasInternetAccess()) {
      return 'No Internet Connection!';
    }
    const uuid = Uuid();
    final v1 = uuid.v1();
    try {
      await firebaseFirestore.collection('rewards').doc('gift-$v1').set(
          RewardData(
                  date: state.validTill!,
                  id: 'gift-$v1',
                  coins: state.coins!,
                  description: state.description,
                  itemLeft: state.itemLeft ?? 0,
                  originalValue: state.originalValue!,
                  isExclusive: state.isExclusive,
                  offerCoins: state.isExclusive ? state.offerCoins! : 0,
                  imageUrl: state.imageUrl,
                  title: state.title)
              .toJson());
      return '';
    } catch (e) {
      return e.toString();
    }
  }

  clearData() {
    state = state.copyWith(
      imageUrl: '',
      title: '',
      description: null,
      coins: null,
      itemLeft: null,
      originalValue: null,
      validTill: null,
      isExclusive: false,
      offerCoins: null,
    );
  }

  Future<String> updateRewardVisibility(String rewardId, bool isPublic) async {
    if (!await hasInternetAccess()) {
      return 'No Internet Connection!';
    }

    try {
      await firebaseFirestore.collection('rewards').doc(rewardId).update(
        {
          "isPublic": isPublic,
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
class ManageRewardsPageState with _$ManageRewardsPageState {
  const factory ManageRewardsPageState({
    @Default(ManageRewardsPageStatus.initial) ManageRewardsPageStatus status,
    @Default(UploadStatus.initial) UploadStatus uploadStatus,
    @Default('') String title,
    @Default(null) String? description,
    @Default(null) int? itemLeft,
    @Default(false) bool isExclusive,
    @Default(null) int? coins,
    @Default(null) int? offerCoins,
    @Default(null) int? originalValue,
    @Default('') String imageUrl,
    @Default(null) String? rewardId,
    @Default(null) DateTime? validTill,
    @Default(null) List<RewardData>? rewardsList,
  }) = _ManageRewardsPageState;
}

enum ManageRewardsPageStatus {
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
