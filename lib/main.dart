import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/authentication/sign_up_screen.dart';
import 'package:tiktok/features/discover/discover_screen.dart';
import 'package:tiktok/features/main_navigation/main_navigation_screen.dart';
import 'package:tiktok/features/onboarding/interests_screen.dart';
import 'package:tiktok/features/inbox/activity_screen.dart';
import 'package:tiktok/features/settings/settings_screen.dart';
import 'package:tiktok/generated/l10n.dart';

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
      // 일종의 번역 파일들을 불러옴
      localizationsDelegates: [
        // 플러터 기본 위젯들을 위한 번역본
        // AppLocalizations.delegate,
        // flutter에는 텍스트가 기본적으로 들어가있는 위젯들이 있는데 ex) licenses는 코드로
        // 작성하지 않아도 텍스트와 함께 보여주는 것들을 말함, 그런 것들을 플러터에서 이미 번역을 해놨는데
        // 아래 3개의 delegate가 그것을 불러오는 것임
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      // localizationsDelegates: AppLocalizations.localizationsDelegates,
      // 앱이 지원하는 언어 명시
      // supportedLocales: AppLocalizations.supportedLocales,
      supportedLocales: [Locale('en'), Locale('ko')],
      debugShowCheckedModeBanner: false,
      // 사용자 로컬 설정에 맞게 dark/light 모드 적용
      themeMode: ThemeMode.system,
      theme: ThemeData(
        useMaterial3: true,
        textTheme: Typography.blackMountainView,
        brightness: Brightness.light,
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
        tabBarTheme: TabBarThemeData(
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey.shade500,
          indicatorColor: Colors.black,
        ),
        listTileTheme: ListTileThemeData(iconColor: Colors.black),
        bottomAppBarTheme: BottomAppBarTheme(color: Colors.grey.shade50),
      ),

      // 다크모드 설정
      darkTheme: ThemeData(
        useMaterial3: true,
        tabBarTheme: TabBarThemeData(
          indicatorColor: Colors.white,
          labelColor: Colors.white,
        ),
        textSelectionTheme: TextSelectionThemeData(
          // 커서 색 설정
          cursorColor: Color(0xFFE9435A),
        ),
        textTheme: Typography.whiteMountainView,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        bottomAppBarTheme: BottomAppBarTheme(color: Colors.grey.shade900),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey.shade900,
          surfaceTintColor: Colors.grey.shade900,
          titleTextStyle: TextStyle(
            fontSize: Sizes.size16 + Sizes.size2,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          actionsIconTheme: IconThemeData(color: Colors.grey.shade100),
        ),
        iconTheme: IconThemeData(color: Colors.grey.shade100),
        primaryColor: Color(0xFFE9435A),
      ),
      home: SignUpScreen(),
    );
  }
}
