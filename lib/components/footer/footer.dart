import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stickify/bloc/app_bloc.dart';
import 'package:stickify/components/components.dart';
import 'package:stickify/core/logger.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ImageEditorBloc>();

    return Column(
      spacing: 10,
      children: [
        AppButton(
          title: "Edit",
          type: ButtonType.secondary,
          onClick: () {
            logger.e('Edit button');
            bloc.add(EditImageEvent(context));
          },
        ),
        AppButton(
          title: "Upload to Telegram",
          type: ButtonType.primary,
          onClick: () {
            logger.e('Upload button');
          },
        ),
      ],
    );
  }
}
