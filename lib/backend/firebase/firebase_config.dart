import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyD-iSI3ZfprPuwSH3OprGsaZ8ZAkCo1CVo",
            authDomain: "orange-a-i-hub-oxjevm.firebaseapp.com",
            projectId: "orange-a-i-hub-oxjevm",
            storageBucket: "orange-a-i-hub-oxjevm.firebasestorage.app",
            messagingSenderId: "887690321833",
            appId: "1:887690321833:web:6e4d54b5ab7d147a5daeb8"));
  } else {
    await Firebase.initializeApp();
  }
}
