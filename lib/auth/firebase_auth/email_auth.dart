// Copyright (c) 2026 Sanjar Karimjonov. All rights reserved.

import 'package:firebase_auth/firebase_auth.dart';

Future<UserCredential?> emailSignInFunc(
  String email,
  String password,
) =>
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email.trim(), password: password);

Future<UserCredential?> emailCreateAccountFunc(
  String email,
  String password,
) =>
    FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
