import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stickify/bloc/app_bloc.dart';
import 'package:stickify/bloc/image_uploader/image_uploader_bloc.dart';
import 'package:stickify/components/components.dart';
import 'package:stickify/theme/app_theme.dart';

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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenButton(
              isActive: true,
              title: 'Upload',
              icon: Icons.arrow_circle_up_rounded,
              roundedSide: RoundedSide.left,
              onClick: () {
                context.read<ImageUploaderBloc>().add(ImageUploadEvent());
              },
            ),
            TweenButton(
              title: 'Generate',
              icon: Icons.star,
              roundedSide: RoundedSide.right,
              onClick: () {
                print('Generate');
              },
            ),
          ],
        ),
      ],
    );
  }
}
