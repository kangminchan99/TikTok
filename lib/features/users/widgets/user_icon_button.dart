import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/constants/sizes.dart';

class UserIconButton extends StatelessWidget {
  final Function() onTap;
  final IconData icon;

  const UserIconButton({required this.onTap, required this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: Sizes.size12,
          horizontal: Sizes.size12,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400, width: Sizes.size1),
          borderRadius: BorderRadius.circular(Sizes.size4),
        ),
        child: FaIcon(icon, size: Sizes.size20),
      ),
    );
  }
}
