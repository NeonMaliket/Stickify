import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stickify/bloc/app_bloc.dart';
import 'package:stickify/bloc/menu_cubit/menu_cubit.dart';
import 'package:stickify/bloc/telegram_cubit/telegram_cubit.dart';
import 'package:stickify/components/components.dart';
import 'package:stickify/components/payment_stars/payment_stars_button.dart';
import 'package:stickify/core/logger.dart';
import 'package:stickify/core/telegram_config.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ImageEditorBloc>();

    final telegramCubit = context.read<TelegramCubit>();
    return Column(
      spacing: 10,
      children: [
        AppButton(
          title: "Edit",
          type: ButtonType.secondary,
          onClick: () {
            logger.i('Edit button');
            bloc.add(EditImageEvent(context));
          },
        ),

        BlocBuilder<MenuCubit, MenuState>(
          builder: (context, state) {
            if (state is UploadMenuItem) {
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
