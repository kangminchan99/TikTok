import 'package:flutter/material.dart';
import 'package:tiktok/constants/sizes.dart';

class AuthButton extends StatelessWidget {
  final String text;
  const AuthButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    // FractionallySizedBox - 부모의 크기에 비례해서 크기를 정하게 해주는 위젯
    return FractionallySizedBox(
      // widthFactor: 1 - 부모의 너비에 100% 비율로 맞춘다.
      widthFactor: 1,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: Sizes.size14),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300, width: Sizes.size1),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: Sizes.size16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
