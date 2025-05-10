import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stickify/bloc/app_bloc.dart';
import 'package:stickify/bloc/main_image_cubit/main_image_cubit.dart';
import 'package:stickify/bloc/telegram_cubit/telegram_cubit.dart';
import 'package:stickify/components/components.dart';
import 'package:stickify/components/payment_stars/payment_stars_button.dart';
import 'package:stickify/core/logger.dart';
import 'package:stickify/core/telegram_config.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final imageEditorBloc = context.read<ImageEditorBloc>();

    final telegramCubit = context.read<TelegramCubit>();
    return Column(
      spacing: 10,
      children: [
        AppButton(
          title: "Edit",
          type: ButtonType.secondary,
          onClick: () {
            logger.i('Edit button');
            imageEditorBloc.add(EditImageEvent(context));
          },
        ),

        BlocBuilder<MainImageCubit, MainImageState>(
          builder: (_, imageState) {
            if (imageState is MainImageEmpty ||
                (imageState is MainImageSelected && !imageState.isGenerated)) {
              return AppButton(
                title: "Upload to Telegram",
                type: ButtonType.primary,
                onClick: () {
                  logger.i('Upload button');
                  telegramCubit.uploadToTelegram("${chatId()}");
                },
              );
            }
            return PaymentStarsButton();
          },
        ),
      ],
    );
  }
}
