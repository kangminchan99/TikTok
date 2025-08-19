import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// 다크모드 체크
bool isDarkMode(BuildContext context) =>
    MediaQuery.of(context).platformBrightness == Brightness.dark;

// 파이어베이스 에러 메시지
void showFirebaseErrorSnackBar(BuildContext context, Object? error) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      showCloseIcon: true,
      // action: SnackBarAction(label: "OK", onPressed: () {}),
      content: Text(
        (error as FirebaseException).message ?? 'something went wrong',
      ),
    ),
  );
}
