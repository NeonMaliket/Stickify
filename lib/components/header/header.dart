import 'package:flutter/material.dart';
import 'package:stickify/core/core.dart';
import 'package:stickify/theme/app_theme.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Sticker Generator',
          style: context.telegramTheme().textTheme.titleLarge,
        ),
        ToggleSwitch(
          borderColor: [context.telegramTheme().colorScheme.primary],
          borderWidth: 1,
          minWidth: context.vw(90),
          minHeight: 50,
          inactiveFgColor: context.telegramTheme().colorScheme.primary,
          inactiveBgColor: context.telegramTheme().colorScheme.secondary,
          iconSize: 25,
          fontSize:
              context.telegramTheme().textTheme.titleSmall?.fontSize ?? 25,

          initialLabelIndex: 0,
          totalSwitches: 2,
          labels: ['Upload', 'Generate'],
          icons: [Icons.arrow_circle_up_rounded, Icons.star],

          animate: true,
          curve: Curves.easeInOut,

          dividerColor: context.telegramTheme().colorScheme.primary,

          onToggle: (index) {
            print('switched to: $index');
          },
        ),
      ],
    );
  }
}
