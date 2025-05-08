import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:new_telegram_web_app/telegram_web_app.dart';
import 'package:stickify/bloc/ai_cubit/ai_cubit.dart';
import 'package:stickify/bloc/app_bloc.dart';
import 'package:stickify/bloc/menu_cubit/menu_cubit.dart';
import 'package:stickify/core/constants/error_messages.dart';
import 'package:stickify/core/dio.dart';
import 'package:stickify/core/logger.dart';

part 'telegram_state.dart';

const _filename = 'sticker.png';

class TelegramCubit extends Cubit<TelegramState> {
  TelegramCubit(
    this._aiCubit,
    this._menuCubit,
    this._imageEditorBloc,
    this._imageUploaderBloc,
  ) : super(TelegramInitial());

  final AiCubit _aiCubit;
  final MenuCubit _menuCubit;

  final ImageEditorBloc _imageEditorBloc;
  final ImageUploaderBloc _imageUploaderBloc;

  void uploadToTelegram(String chatId) async {
    Uint8List? sticker;

    final editorState = _imageEditorBloc.state;
    final imageGeneratorState = _aiCubit.state;
    final imageUploaderState = _imageUploaderBloc.state;
    if (editorState is EditCompleteState && _menuCubit.isUploadItem()) {
      sticker = editorState.editedImage;
    } else if (imageUploaderState is ImageUploadCompleteState &&
        _menuCubit.isUploadItem()) {
      sticker = imageUploaderState.file;
    } else if (imageGeneratorState is AiGenerated &&
        _menuCubit.isGenerateItem()) {
      sticker = imageGeneratorState.resource;
    }

    if (sticker == null) {
      emit(TelegramUploadError(stickerIsAbsentErrorMessage));
      return;
    }

    final path = "${serverHost()}/api/v1/stickify/upload/$chatId";
    logger.i('Uploading sticker to telegram');
    logger.i('Path: $path');
    try {
      emit(TelegramUploadingInProgress());
      final formData = FormData.fromMap({
        'sticker': MultipartFile.fromBytes(sticker, filename: _filename),
      });
      final response = await dio.post(path, data: formData);
      if (response.statusCode == 200) {
        emit(TelegramUploaded());
      } else {
        emit(TelegramUploadError(uploadFailedErrorMessage));
      }
    } catch (e) {
      emit(TelegramUploadError(e.toString()));
    }
  }
}
