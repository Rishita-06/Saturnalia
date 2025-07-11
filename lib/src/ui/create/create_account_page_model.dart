import 'dart:convert' as convert;
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:Saturnalia/src/logic/repositories/app_repository/app_repository.dart';
import 'package:Saturnalia/src/utils/network_utils.dart';

import '../../logic/services/firebase_firestore.dart';
import '../../models/reward_points_data.dart';
import '../../models/user_data.dart';

part 'create_account_page_model.freezed.dart';

final createAccountPageProvider = StateNotifierProvider.autoDispose<
    CreateAccountPageModel, CreateAccountPageState>(
  (ref) => CreateAccountPageModel(
    firebaseFirestore: ref.read(firebaseFirestoreProvider),
    ref: ref,
  ),
);

class CreateAccountPageModel extends StateNotifier<CreateAccountPageState> {
  final FirebaseFirestore firebaseFirestore;
  final AutoDisposeStateNotifierProviderRef ref;
  CreateAccountPageModel({
    required this.firebaseFirestore,
    required this.ref,
  }) : super(const CreateAccountPageState()) {
    init();
  }

  init() async {
    final userEmail =
        ref.read(appRepositoryProvider.select((_) => _.authUser?.email)) ?? '';
    state = state.copyWith(
      isThaparStudent: Platform.isIOS
          ? userEmail.trim().isEmpty
              ? false
              : userEmail.split('@')[1] == 'thapar.edu'
          : userEmail.split('@')[1] == 'thapar.edu',
      status: CreatePageStatus.loading,
    );
    await Future.delayed(const Duration(milliseconds: 500));
    if (!(await hasInternetAccess())) {
      state = state.copyWith(
        status: CreatePageStatus.error,
      );
      return;
    }
    final data = await ref
        .read(firebaseFirestoreProvider)
        .collection('users')
        .doc(ref.read(appRepositoryProvider.select((_) => _.authUser?.uid)))
        .get();

    if (data.exists) {
      final userData = data.data() as Map;
      state = state.copyWith(
        eligible: false,
        name: userData['userName'],
        email: userData['email'],
        mobile: userData['phoneNumber'],
        rollNumber: userData['rollNumber'],
        gender: userData['gender'],
        collegeName: userData['collegeName'] ?? '',
        collegeCity: userData['collegeCity'] ?? '',
        collegeState: userData['collegeState'] ?? '',
        collegePinCode: userData['collegePinCode'],
        branch: userData['branch'] ?? '',
        coins: userData['coins'] ?? 0,
        roleId: userData['roleId'] ?? 2,
        roles: (userData['roles'] as List<dynamic>?)
                ?.map((e) => e as int)
                .toList() ??
            [],
        isAdmin: userData['isAdmin'] ?? false,
        events: ((userData['events'] ?? []) as List)
            .map((e) => e.toString())
            .toList(),
        graduationYear: userData['graduationYear'],
        status: CreatePageStatus.loaded,
      );
    } else {
      state = state.copyWith(
        status: CreatePageStatus.loaded,
      );
    }
  }

  String generateReferralCode(String email, bool isReferral) {
    final bytes = convert.utf8.encode(email);
    final hash = sha256.convert(bytes);
    return isReferral
        ? hash.toString().substring(0, 6)
        : hash.toString().substring(0, 8);
  }

  setCollegeName(String value) {
    state = state.copyWith(collegeName: value);
  }

  setCollegeCity(String value) {
    state = state.copyWith(collegeCity: value);
  }

  setCollegeState(String value) {
    state = state.copyWith(collegeState: value);
  }

  setName(String value) {
    state = state.copyWith(name: value);
  }

  setEmail(String value) {
    state = state.copyWith(email: value);
  }

  setCollegePinCode(int value) {
    state = state.copyWith(collegePinCode: value);
  }

  setGraduationYear(String value) {
    state = state.copyWith(graduationYear: value);
  }

  setReferralCode(String value) {
    state = state.copyWith(referalCode: value);
  }

  setPhone(int value) {
    state = state.copyWith(mobile: value);
  }

  setGender(int gender) {
    state = state.copyWith(
      gender: gender,
    );
  }

  setBranch(String branch) {
    state = state.copyWith(
      branch: branch,
    );
  }

  setRollNumber(int value) {
    state = state.copyWith(rollNumber: value);
  }

  Future<String> createAccount() async {
    final user = ref.read(appRepositoryProvider.select((_) => _.authUser));
    if (Platform.isIOS && (user?.displayName == null || user?.email == null)) {
      if (state.name.trim().isEmpty) {
        return 'Please enter your name';
      }
      if (state.email.trim().isEmpty) {
        return 'Please enter your email';
      } else if (state.email.trim().split('@').length != 2) {
        return 'please enter valid email';
      } else if (state.email.trim().split('@')[1] != 'gmail.com') {
        return 'please enter valid email';
      }
    }
    if (state.mobile == null || state.mobile.toString().length != 10) {
      return 'Please enter phone number';
    }
    if (state.gender == null) {
      return 'Please enter gender';
    }
    if (state.isThaparStudent!) {
      if (state.rollNumber == null || state.rollNumber.toString().length != 9) {
        return 'Please enter roll number';
      }
    } else {
      if (state.collegeName.trim().isEmpty) {
        return 'Please enter college name';
      }
      if (state.collegeCity.trim().isEmpty) {
        return 'Please enter college city';
      }
      if (state.collegeState.trim().isEmpty) {
        return 'Please enter college name';
      }
      if (state.collegePinCode == null ||
          state.collegePinCode.toString().length != 6) {
        return 'Please enter college pin code';
      }
    }
    if (state.branch.trim().isEmpty) {
      return 'Please enter stream(branch)';
    }
    if (state.graduationYear == null) {
      return 'Please enter graduation year';
    }
    final referralId = (await checkReferralCode(state.referalCode));
    if (state.referalCode.trim().isNotEmpty) {
      if (referralId == '') {
        return 'Invalid referral code';
      }
    }
    if (!(await hasInternetAccess())) {
      return 'No internet connection!';
    }
    if (state.referalCode.trim().isNotEmpty) {
      if (referralId != '') {
        await firebaseFirestore
            .collection('users')
            .doc(user!.uid)
            .collection('rewards')
            .doc('Referral$referralId')
            .set(
              RewardPointsData(
                date: DateTime.now(),
                message: 'Scanned',
                id: 'Referral$referralId',
                coins: 5,
                isAwarded: 1,
                title: 'Reward for Success Referral',
              ).toJson(),
            );
        await firebaseFirestore
            .collection('users')
            .doc(referralId)
            .collection('rewards')
            .doc('Referral${user.uid}')
            .set(
              RewardPointsData(
                date: DateTime.now(),
                message: 'Scanned',
                id: 'Referral${user.uid}',
                coins: 5,
                isAwarded: 1,
                title: 'Reward for Success Referral',
              ).toJson(),
            );
      }
    }
    try {
      await firebaseFirestore.collection('users').doc(user!.uid).set(
            UserData(
              userId: user.uid,
              userName: Platform.isIOS && user.displayName == null
                  ? state.name
                  : user.displayName!,
              email: Platform.isIOS && user.email == null
                  ? state.email
                  : user.email!,
              profilePicUrl: user.photoURL ?? 's',
              collegeCity:
                  state.isThaparStudent! ? 'Patiala' : state.collegeCity.trim(),
              collegeName: state.isThaparStudent!
                  ? 'Thapar University'
                  : state.collegeName.trim(),
              collegePinCode:
                  state.isThaparStudent! ? 147004 : state.collegePinCode!,
              collegeState:
                  state.isThaparStudent! ? 'Punjab' : state.collegeState.trim(),
              graduationYear: state.graduationYear!,
              referalCode: generateReferralCode(user.uid, true).toUpperCase(),
              branch: state.branch,
              gender: state.gender!,
              phoneNumber: state.mobile!,
              rollNumber: state.rollNumber,
              roles: state.roles,
              isAdmin: state.isAdmin ?? false,
              events: state.events ?? [],
              uniqueId: generateReferralCode(user.uid.substring(5, 15), false),
              coins: state.eligible
                  ? referralId != ''
                      ? 5
                      : 0
                  : state.coins,
            ).toJson(),
          );
    } catch (e) {
      await firebaseFirestore.collection('users').doc(user!.uid).set(
            UserData(
              userId: user.uid,
              userName: Platform.isIOS && user.displayName == null
                  ? state.name
                  : user.displayName!,
              email: Platform.isIOS && user.email == null
                  ? state.email
                  : user.email!,
              profilePicUrl: user.photoURL ?? 's',
              collegeCity:
                  state.isThaparStudent! ? 'Patiala' : state.collegeCity.trim(),
              collegeName: state.isThaparStudent!
                  ? 'Thapar University'
                  : state.collegeName.trim(),
              collegePinCode:
                  state.isThaparStudent! ? 147004 : state.collegePinCode!,
              collegeState:
                  state.isThaparStudent! ? 'Punjab' : state.collegeState.trim(),
              graduationYear: state.graduationYear!,
              referalCode: generateReferralCode(user.uid, true).toUpperCase(),
              branch: state.branch,
              gender: state.gender!,
              phoneNumber: state.mobile!,
              rollNumber: state.rollNumber,
              isAdmin: state.isAdmin ?? false,
              roles: state.roles,
              events: state.events ?? [],
              uniqueId: generateReferralCode(user.uid.substring(5, 15), false),
              coins: state.eligible
                  ? referralId != ''
                      ? 5
                      : 0
                  : state.coins,
            ).toJson(),
          );
    }
    return '';
  }

  Future<String> checkReferralCode(String referralCode) async {
    final res = await firebaseFirestore
        .collection('users')
        .where('referalCode', isEqualTo: referralCode.toUpperCase())
        .get();

    if (res.docs.isNotEmpty) {
      return res.docs.first.id;
    }
    return '';
  }
}

@freezed
class CreateAccountPageState with _$CreateAccountPageState {
  const factory CreateAccountPageState({
    @Default('') String collegeName,
    @Default('') String collegeCity,
    @Default('') String name,
    @Default('') String email,
    @Default('') String collegeState,
    @Default(null) int? collegePinCode,
    @Default(null) String? graduationYear,
    @Default(null) int? mobile,
    @Default('') String branch,
    @Default(null) int? rollNumber,
    @Default(null) List<String>? events,
    @Default(0) int coins,
    @Default(null) String? fcmId,
    @Default(2) int roleId,
    @Default(null) int? gender,
    @Default(true) bool eligible,
    @Default('') String referalCode,
    @Default(false) bool? isAdmin,
    @Default(null) List<int>? roles,
    @Default(null) bool? isThaparStudent,
    @Default(CreatePageStatus.initial) CreatePageStatus status,
  }) = _CreateAccountPageState;
}

enum CreatePageStatus {
  initial,
  loading,
  loaded,
  error,
}
