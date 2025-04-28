import 'package:flutter/material.dart';
import 'package:stickify/core/core.dart';
import 'package:stickify/theme/app_theme.dart';

class UploadSelect extends StatelessWidget {
  const UploadSelect({super.key, required this.onTap, required this.child});

  final Function() onTap;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.all(Radius.circular(20));
    return Material(
      color: Colors.white.withAlpha(70),
      borderRadius: borderRadius,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            border: Border.all(
              width: 1.2,
              color: context.telegramTheme().colorScheme.primary,
            ),
          ),
          width: context.vw(70),
          height: context.vw(70),
          alignment: Alignment.center,
          child: child,
        ),
      ),
    );
  }
}
