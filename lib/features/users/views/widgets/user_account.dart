import 'package:flutter/material.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';

class UserAccount extends StatelessWidget {
  final String account;
  final String title;
  const UserAccount({super.key, required this.account, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          account,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: Sizes.size18),
        ),
        Gaps.v3,
        Text(title, style: TextStyle(color: Colors.grey.shade500)),
      ],
    );
  }
}
