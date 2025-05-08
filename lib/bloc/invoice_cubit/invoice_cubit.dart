import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:stickify/core/dio.dart';
import 'package:stickify/core/logger.dart';
import 'package:stickify/core/telegram_config.dart';

part 'invoice_state.dart';

class InvoiceCubit extends Cubit<InvoiceState> {
  InvoiceCubit() : super(InvoiceInitial());

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
