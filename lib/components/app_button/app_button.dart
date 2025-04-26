import 'package:flutter/material.dart';
import 'package:stickify/core/core.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.title,
    required this.type,
    required this.onClick,
    this.icon,
    this.width = 100,
    this.borderRadius,
  });

  final String title;
  final ButtonType type;
  final Function() onClick;
  final Icon? icon;
  final double width;

  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.vw(width),
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
            type.isPrimary() ? Colors.blue : Colors.white,
          ),
          foregroundColor: WidgetStatePropertyAll(Colors.blue),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(12),
              side: BorderSide(color: Colors.blue, width: 1),
            ),
          ),
        ),
        onPressed: onClick,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon ?? SizedBox.shrink(),
            SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(
                color: type.isPrimary() ? Colors.white : Colors.blue,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum ButtonType {
  primary,
  secondary;

  bool isPrimary() {
    return this == ButtonType.primary;
  }
}
