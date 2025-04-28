import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:stickify/core/dio.dart';
import 'package:stickify/core/logger.dart';

part 'ai_state.dart';

class AiCubit extends Cubit<AiState> {
  AiCubit() : super(AiInitial());

  void sendToAi(final String prompt) async {
    final path = "$serverHost/api/v1/stickify/generate";
    emit(AiGenerating());
    logger.i('Generation with prompt: $prompt');
    logger.i('Path: $path');
    final response = await dio.post(
      path,
      data: {'prompt': prompt},
      options: Options(responseType: ResponseType.bytes),
    );

    if (response.data == null) {
      emit(AiGenerationError('Generation error'));
      return;
    }

    emit(AiGenerated(response.data ?? Uint8List(0)));
  }
}
