import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:new_telegram_web_app/telegram_web_app.dart';
import 'package:stickify/bloc/invoice_cubit/invoice_cubit.dart';
import 'package:stickify/bloc/loader_cubit/loader_cubit.dart';
import 'package:stickify/core/dio.dart';
import 'package:stickify/core/logger.dart';
import 'package:stickify/core/telegram_config.dart';

part 'ai_state.dart';

class AiCubit extends Cubit<AiState> {
  AiCubit(this._loaderCubit, this._invoiceCubit) : super(AiInitial());

  final LoaderCubit _loaderCubit;
  final InvoiceCubit _invoiceCubit;

  void sendToAi(final String prompt) async {
    var generateInvoiceLink = _invoiceCubit.generateInvoiceLink(prompt);

    generateInvoiceLink.then((link) => telegramWebApp().openInvoice(link, (status) {
      logger.i('INVOICE STATUS: $status');
    }));


    final path = "${serverHost()}/api/v1/stickify/generate";
    emit(AiGenerating());
    _loaderCubit.loading();
    logger.i('Generation with prompt: $prompt');
    logger.i('Path: $path');
    final response = await dio
        .post(
          path,
          data: {'prompt': prompt, 'chatId': chatId()},
          options: Options(responseType: ResponseType.bytes),
        )
        .onError((_, __) {
          _loaderCubit.loaded();
          emit(AiGenerationError('Generation error'));
          return Future.error('DIO error');
        });

    if (response.data == null) {
      _loaderCubit.loaded();
      emit(AiGenerationError('Generation error'));
      return;
    }

    _loaderCubit.loaded();
    emit(AiGenerated(response.data ?? Uint8List(0)));
  }
}
