// Copyright (c) 2026 Sanjar Karimjonov. All rights reserved.

import 'package:firebase_auth/firebase_auth.dart';

Future<UserCredential?> anonymousSignInFunc() =>
    FirebaseAuth.instance.signInAnonymously();
