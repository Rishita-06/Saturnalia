import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>(
  (ref) => FirebaseAuth.instance,
);

final googleAuthProvider = Provider<GoogleSignIn>(
  (ref) => GoogleSignIn(clientId: Platform.isAndroid ? null : "1090126510576-rgjcni61o90qthenkhavcu16vi3hrols.apps.googleusercontent.com",),
);
