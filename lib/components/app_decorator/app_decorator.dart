import 'package:flutter/material.dart';
import 'package:stickify/components/app_alert/app_alert.dart';
import 'package:stickify/features/loader/loader.dart';

class AppDecorator extends StatelessWidget {
  const AppDecorator({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AppAlert(child: Loader(child: child));
  }
}
