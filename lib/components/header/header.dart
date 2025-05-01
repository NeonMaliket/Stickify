import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stickify/bloc/menu_cubit/menu_cubit.dart';
import 'package:stickify/core/core.dart';
import 'package:stickify/theme/app_theme.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    final menuCubit = context.read<MenuCubit>();
    return Column(
      children: [
        // Text(
        //   'Sticker Generator',
        //   style: context.telegramTheme().textTheme.titleLarge,
        // ),
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
          initialLabelIndex: context.watch<MenuCubit>().state.index,
          totalSwitches: 2,
          labels: ['Upload', 'Generate'],
          icons: [Icons.arrow_circle_up_rounded, Icons.star],
          animate: true,
          curve: Curves.easeInOut,
          dividerColor: context.telegramTheme().colorScheme.primary,
          onToggle: menuCubit.followBy,
        ),
      ],
    );
  }
}
