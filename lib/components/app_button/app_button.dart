import 'package:flutter/material.dart';
import 'package:stickify/core/core.dart';
import 'package:stickify/theme/app_theme.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.title,
    required this.type,
    required this.onClick,
    this.enabled = true,
    this.tile,
    this.width = 100,
    this.borderRadius,
  });

  final String title;
  final ButtonType type;
  final Function() onClick;
  final Widget? tile;
  final double width;
  final bool enabled;

  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    var primaryColor = context.telegramTheme().colorScheme.primary;
    var secondaryColor = context.telegramTheme().colorScheme.secondary;
    return SizedBox(
      width: context.vw(width),
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
            type.isPrimary()
                ? primaryColor
                : context.telegramTheme().colorScheme.secondary,
          ),
          foregroundColor: WidgetStatePropertyAll(primaryColor),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(12),
              side: BorderSide(color: primaryColor, width: 1),
            ),
          ),
        ),
        onPressed: () {
          if (enabled) {
            onClick();
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            tile ?? SizedBox.shrink(),
            SizedBox(width: 10),
            Theme(
              data: ThemeData(
                textTheme: context.telegramTheme().textTheme.copyWith(
                  titleSmall: context.telegramTheme().textTheme.titleSmall?.copyWith(
                    color: type.isPrimary() ? secondaryColor : primaryColor,
                  )
                )
              ),
              child: Text(
                title,
                style: context.telegramTheme().textTheme.titleSmall?.copyWith(
                  color: type.isPrimary() ? secondaryColor : primaryColor,
                ),
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
