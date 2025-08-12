import 'package:flutter/material.dart';

class FlashModeButton extends StatelessWidget {
  const FlashModeButton({
    super.key,
    required this.icon,
    required this.isActive,
    required this.onPressed,
  });

  final IconData icon;
  final bool isActive;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: isActive ? Colors.yellow : Colors.white,
        size: 40,
      ),
    );
  }
}
