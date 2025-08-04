import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/authentication/sign_up_screen.dart';
import 'package:tiktok/features/main_navigation/main_navigation_screen.dart';
import 'package:tiktok/features/onboarding/interests_screen.dart';
import 'package:tiktok/features/inbox/activity_screen.dart';

void main() async {
  // flutter engine과 framework를 묶는 접착제
  WidgetsFlutterBinding.ensureInitialized();
  // 앱이 시작될 때 세로 모드로 고정
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const TikTokApp());
}

class TikTokApp extends StatelessWidget {
  const TikTokApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // 기본 배경색 전역 설정
        scaffoldBackgroundColor: Colors.white,
        textSelectionTheme: TextSelectionThemeData(
          // 커서 색 설정
          cursorColor: Color(0xFFE9435A),
        ),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        // 틱톡 시그니처 색상 전역 설정
        primaryColor: Color(0xFFE9435A),
        // 앱바 테마 전역 설정
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          shadowColor: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          titleTextStyle: TextStyle(
            fontSize: Sizes.size16 + Sizes.size2,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      home: MainNavigationScreen(),
    );
  }
}
