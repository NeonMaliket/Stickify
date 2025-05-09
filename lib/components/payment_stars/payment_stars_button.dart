import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stickify/bloc/ai_cubit/ai_cubit.dart';
import 'package:stickify/bloc/invoice_cubit/invoice_cubit.dart';
import 'package:stickify/bloc/telegram_cubit/telegram_cubit.dart';
import 'package:stickify/components/app_button/app_button.dart';
import 'package:stickify/core/logger.dart';
import 'package:stickify/core/telegram_config.dart';
import 'package:stickify/theme/app_theme.dart';

class PaymentStarsButton extends StatelessWidget {
  const PaymentStarsButton({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocListener<InvoiceCubit, InvoiceState>(
      listener: (BuildContext context, InvoiceState state) {
        if (state is AiInvoicePaidSuccessState) {
          context.read<TelegramCubit>().uploadToTelegram("${chatId()}");
        }
      },
      child: BlocBuilder<AiCubit, AiState>(
        builder: (context, aiCubitState) {
          return AppButton(
            title: "Upload to Telegram",
            tile: Row(
              children: [
                Text("100", style: telegramWebAppTheme.textTheme.titleSmall),
                Image.asset(
                  'assets/images/star_icon.png',
                  width: 30,
                  height: 30,
                ),
              ],
            ),
            type: ButtonType.primary,
            onClick: () {
              logger.i('Payment button');
              if (aiCubitState is AiGenerated) {
                final prompt = aiCubitState.prompt;
                context.read<InvoiceCubit>().payAiInvoice(prompt);
              }
            },
          );
        },
      ),
    );
  }
}
