import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

import '../../logic/services/firebase_auth.dart';
import '../../logic/services/firebase_firestore.dart';
import '../../utils/network_utils.dart';

part 'auth_page_model.freezed.dart';

final authPageModelProvider =
    StateNotifierProvider.autoDispose<AuthPageModel, AuthPageState>(
  (ref) => AuthPageModel(
      firebaseAuth: ref.watch(firebaseAuthProvider),
      googleSignIn: ref.watch(googleAuthProvider),
      firebaseFirestore: ref.watch(firebaseFirestoreProvider)),
);

class AuthPageModel extends StateNotifier<AuthPageState> {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;
  final FirebaseFirestore firebaseFirestore;

  AuthPageModel(
      {required this.firebaseAuth,
      required this.googleSignIn,
      required this.firebaseFirestore})
      : super(const AuthPageState());
  Future<String> signin({bool isThaparId = false}) async {
    if (!(await hasInternetAccess())) {
      return 'No internet connection!';
    }
    state = state.copyWith(
      status: AuthPageStatus.authenticatingWithGoogle,
    );

    try {
      if (mounted) {
        GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

        GoogleSignInAuthentication? googleSignInAuthentication =
            await googleSignInAccount?.authentication;

        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication?.accessToken,
          idToken: googleSignInAuthentication?.idToken,
        );
        await FirebaseAuth.instance.signInWithCredential(credential);
        state = state.copyWith(
          status: AuthPageStatus.authenticated,
        );
        return '';
      }
      return '';
    } catch (e) {
      state = state.copyWith(
        status: AuthPageStatus.error,
      );
      return e.toString();
    }
  }

  Future<String> signInWithApple({List<Scope> scopes = const []}) async {
    if (!(await hasInternetAccess())) {
      return 'No internet connection!';
    }
    state = state.copyWith(
      status: AuthPageStatus.authenticatingWithApple,
    );
    final result = await TheAppleSignIn.performRequests(
        [AppleIdRequest(requestedScopes: scopes)]);
    try {
      switch (result.status) {
        case AuthorizationStatus.authorized:
          final appleIdCredential = result.credential!;
          final oAuthProvider = OAuthProvider('apple.com');
          final credential = oAuthProvider.credential(
              idToken: String.fromCharCodes(appleIdCredential.identityToken!));

          await firebaseAuth.signInWithCredential(credential);
          if (scopes.contains(Scope.fullName)) {
            final fullName = appleIdCredential.fullName;
            if (fullName != null &&
                fullName.givenName != null &&
                fullName.familyName != null) {
              final displayName =
                  '${fullName.givenName} ${fullName.familyName}';
              await firebaseAuth.currentUser?.updateDisplayName(displayName);
            }
          }
          state = state.copyWith(
            status: AuthPageStatus.authenticated,
          );
          return '';
        case AuthorizationStatus.error:
          state = state.copyWith(
            status: AuthPageStatus.error,
          );
          return 'ERROR_AUTHORIZATION_DENIED';

        case AuthorizationStatus.cancelled:
          state = state.copyWith(
            status: AuthPageStatus.error,
          );
          return 'Sign in aborted by user';

        default:
          return 'Authentication Failed';
      }
    } catch (e) {
      return e.toString();
    }
  }
}

@freezed
class AuthPageState with _$AuthPageState {
  const factory AuthPageState({
    @Default(AuthPageStatus.initial) AuthPageStatus status,
    String? errorMessage,
  }) = _AuthPageState;
}

enum AuthPageStatus {
  initial,
  authenticatingWithGoogle,
  authenticatingWithApple,
  authenticated,
  error,
}
