import 'package:flutter/material.dart';
import 'package:tiktok/screens/sign_up/sign_up_screen.dart';

void main() {
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
        // 틱톡 시그니처 색상
        primaryColor: Color(0xFFE9435A),
      ),
      home: SignUpScreen(),
    );
  }
}
