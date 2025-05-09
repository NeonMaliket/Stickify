import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:new_telegram_web_app/telegram_web_app.dart';
import 'package:stickify/bloc/ai_cubit/ai_cubit.dart';
import 'package:stickify/bloc/alert_cubit/alert_cubit.dart';
import 'package:stickify/bloc/loader_cubit/loader_cubit.dart';
import 'package:stickify/core/dio.dart';
import 'package:stickify/core/logger.dart';
import 'package:stickify/core/telegram_config.dart';

part 'invoice_state.dart';

class InvoiceCubit extends Cubit<InvoiceState> {
  InvoiceCubit(this._loaderCubit, this._alertCubit, this._aiCubit)
    : super(InvoiceInitial());

  final AiCubit _aiCubit;
  final AlertCubit _alertCubit;
  final LoaderCubit _loaderCubit;

  Future<void> payAiInvoice(prompt) async {
    _loaderCubit.loading();
    await generateInvoiceLink(prompt).then(
      (link) => telegramWebApp().openInvoice(link, (status) {
        logger.i('INVOICE STATUS: $status');
        switch (status) {
          case InvoiceStatus.paid:
            emit(AiInvoicePaidSuccessState());
            _aiCubit.sendToAi(prompt);
            _loaderCubit.loaded();
          case InvoiceStatus.cancelled:
            emit(AiInvoiceUserRejectState());
            _alertCubit.showError('Payment canceled');
            _loaderCubit.loaded();
          case InvoiceStatus.failed:
            var errorMessage = 'Invoice failed';
            emit(AiInvoiceErrorState(errorMessage));
            _alertCubit.showError(errorMessage);
            _loaderCubit.loaded();
          case InvoiceStatus.pending:
            emit(AiInvoiceInProgressState());
        }
      }),
    );
  }

  Future<String> generateInvoiceLink(String prompt) async {
    logger.i('Invoice link generation');

    emit(InvoiceLinkGeneratingState());
    final path = "${serverHost()}/api/v1/invoices/link";
    final localChatId = chatId();
    final body = {'chat_id': localChatId, 'prompt': prompt};
    logger.i('Invoice server url: $path');
    final response = await dio.post(path, data: body).onError((_, __) {
      final errorMessage = "Invoice creation error";
      logger.e(errorMessage);
      emit(InvoiceLinkGenerationErrorState(errorMessage));
      return Future.error(errorMessage);
    });

    final String generatedLink = response.data?["result"] ?? "";

    if (generatedLink.isEmpty) {
      final message = "Invoice response is empty";
      logger.e(message);
      emit(InvoiceLinkGenerationErrorState(message));
      throw message;
    }

    emit(InvoiceLinkGeneratedState(generatedLink));

    logger.i('Invoice link generated: $generatedLink');

    return generatedLink;
  }
}
