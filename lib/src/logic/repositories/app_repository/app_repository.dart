import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../models/sponsers_app_data.dart';
import '../../../models/user_data.dart';
import '../../services/firebase_auth.dart';
import '../../services/firebase_firestore.dart';
import '../../services/firebase_messaging.dart';

part 'app_repository.freezed.dart';

final appRepositoryProvider = StateNotifierProvider<AppRepository, AppState>(
  (ref) => AppRepository(
    firebaseAuth: ref.read(firebaseAuthProvider),
    firebaseFirestore: ref.read(firebaseFirestoreProvider),
    googleSignIn: ref.read(googleAuthProvider),
    ref: ref,
    firebaseMessaging: ref.read(firebaseMessagingProvider),
  ),
);

class AppRepository extends StateNotifier<AppState> {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  late final StreamSubscription _authSubscription;
  GoogleSignIn? googleSignIn;
  StreamSubscription? _userDataSubscription;
  StreamSubscription? _subscription;
  final FirebaseMessaging firebaseMessaging;
  late Timer? timer;
  final StateNotifierProviderRef ref;

  AppRepository({
    required this.firebaseAuth,
    required this.firebaseFirestore,
    required this.googleSignIn,
    required this.firebaseMessaging,
    required this.ref,
  }) : super(const AppState()) {
    _authSubscription = firebaseAuth.authStateChanges().listen((user) async {
      _userDataSubscription?.cancel();
      state = state.copyWith(
        authUser: user,
      );
      // if (!await checkAppVersion()) {
      //   state = state.copyWith(
      //     status: AppStatus.updateApp,
      //   );
      // } else
        if (user == null) {
        // debugPrint('user is null');

        state = state.copyWith(
          status: AppStatus.unauthenticated,
        );
      } else {
        // debugPrint('user is not null');

        _userDataSubscription = firebaseFirestore
            .collection('users')
            .doc(user.uid)
            .snapshots()
            .listen((documentSnapshot) async {
          if (documentSnapshot.exists) {
            // if (!await checkMaintainanceState(
            //     documentSnapshot.data()?['roleId'] ?? 2)) {
            //   state = state.copyWith(status: AppStatus.maintainance);
            //   return;
            // }
            await checkSelectedEvent();

            try {
              state = state.copyWith(
                thaparId: user.email?.split('@')[1] == 'thapar.edu',
                userData: UserData.fromJson(documentSnapshot.data()!),
              );
            } catch (e) {
              state = state.copyWith(
                thaparId: user.email?.split('@')[1] == 'thapar.edu',
                status: AppStatus.createAccount,
              );
              return;
            }
            state = state.copyWith(
              thaparId: user.email?.split('@')[1] == 'thapar.edu',
              status: AppStatus.authenticated,
            );
          } else {
            // if (!await checkMaintainanceState(2)) {
            //   state = state.copyWith(status: AppStatus.maintainance);
            //   return;
            // }
            await checkSelectedEvent();
            state = state.copyWith(
              thaparId: user.email?.split('@')[1] == 'thapar.edu',
              status: AppStatus.createAccount,
            );
          }
        });
      }
    });
  }

  Future<bool> checkAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    String packageName = packageInfo.version;
    final version = await ref
        .read(firebaseFirestoreProvider)
        .collection('app')
        .doc('versions')
        .get();
    final versions = Platform.isAndroid
        ? (version.data() as Map)['android']
            .toString()
            .split('.')
            .map((e) => int.parse(e))
            .toList()
        : (version.data() as Map)['ios']
            .toString()
            .split('.')
            .map((e) => int.parse(e))
            .toList();
    final packageVersions =
        packageName.split('.').map((e) => int.parse(e)).toList();
    if (versions[0] < packageVersions[0]) {
      return true;
    } else if (versions[0] == packageVersions[0]) {
      if (versions[1] < packageVersions[1]) {
        return true;
      } else if (versions[1] == packageVersions[1]) {
        if (versions[2] <= packageVersions[2]) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<void> checkSelectedEvent() async {
    final selectedEvent = await ref
        .read(firebaseFirestoreProvider)
        .collection('app')
        .doc('selectedEvent')
        .get();

    if (selectedEvent.exists) {
      if (((selectedEvent.data()?['selectedEvent'] ?? "").toString().trim())
          .isNotEmpty) {
        if (mounted) {
          state = state.copyWith(
            selectedEvent: selectedEvent.data()?['selectedEvent'],
          );
        }
      } else {
        state = state.copyWith(
          selectedEvent: ((selectedEvent.data()?['events'] as List?) ?? [])
              .first
              .toString(),
        );
      }
    } else {
      state = state.copyWith(
        selectedEvent: 'sat24',
      );
    }
  }

  Future<bool> checkMaintainanceState(int roleId) async {
    final version = await ref
        .read(firebaseFirestoreProvider)
        .collection('app')
        .doc('maintainence')
        .get();
    final versions = Platform.isAndroid
        ? ((version.data() as Map)['android'] as bool)
        : ((version.data() as Map)['ios'] as bool);
    if (versions || roleId != 2) {
      return true;
    }
    return false;
  }

  Future<String> logout({bool isFromCreatePage = false}) async {
    try {
      await googleSignIn?.disconnect();
      await firebaseAuth.signOut();
      return '';
    } catch (e) {
      return 'Something Went Wrong';
    }
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
    _authSubscription.cancel();
    _userDataSubscription?.cancel();
    _subscription?.cancel();
  }
}

@freezed
class AppState with _$AppState {
  const factory AppState({
    @Default(null) User? authUser,
    @Default(null) UserData? userData,
    @Default(false) bool thaparId,
    @Default(null) String? selectedEvent,
    @Default(AppStatus.initial) AppStatus status,
    @Default(null) List<SponserAppData>? sponserApp,
    @Default(null) DateTime? lastFcmIDUpdatedAt,
  }) = _AppState;
}

enum AppStatus {
  initial,
  unauthenticated,
  authenticated,
  createAccount,
  maintainance,
  noSponserAppsInstalled,
  updateApp,
}
