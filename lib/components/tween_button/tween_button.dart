import 'package:flutter/material.dart';
import 'package:stickify/components/components.dart';

class TweenButton extends StatelessWidget {
  const TweenButton({
    super.key,
    required this.title,
    required this.icon,
    required this.roundedSide,
    required this.onClick,
    this.isActive = false,
  });

  final bool isActive;
  final String title;
  final IconData icon;
  final RoundedSide roundedSide;
  final Function() onClick;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      title: title,
      type: isActive ? ButtonType.primary : ButtonType.secondary,
      width: 45,
      icon: Icon(icon, size: 25, color: isActive ? Colors.white : Colors.blue),
      borderRadius: _borderRadius(),
      onClick: () {
        onClick();
      },
    );
  }

  BorderRadius _borderRadius() {
    return roundedSide.isRight()
        ? BorderRadius.only(
          topLeft: Radius.zero,
          bottomLeft: Radius.zero,
          topRight: Radius.circular(12),
          bottomRight: Radius.circular(12),
        )
        : BorderRadius.only(
          topRight: Radius.zero,
          bottomRight: Radius.zero,
          topLeft: Radius.circular(12),
          bottomLeft: Radius.circular(12),
        );
  }
}

enum RoundedSide {
  left,
  right;

  bool isRight() {
    return this == RoundedSide.right;
  }
}
