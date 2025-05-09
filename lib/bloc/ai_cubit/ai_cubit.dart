import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:stickify/bloc/loader_cubit/loader_cubit.dart';
import 'package:stickify/core/dio.dart';
import 'package:stickify/core/logger.dart';
import 'package:stickify/core/telegram_config.dart';

part 'ai_state.dart';

class AiCubit extends Cubit<AiState> {
  AiCubit(this._loaderCubit) : super(AiInitial());

  final LoaderCubit _loaderCubit;

  void sendToAi(final String prompt) async {
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
    emit(AiGenerated(prompt, response.data ?? Uint8List(0)));
  }
}
