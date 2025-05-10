import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:stickify/bloc/main_image_cubit/main_image_cubit.dart';
import 'package:stickify/core/constants/error_messages.dart';
import 'package:stickify/core/dio.dart';
import 'package:stickify/core/logger.dart';

part 'telegram_state.dart';

const _filename = 'sticker.png';

class TelegramCubit extends Cubit<TelegramState> {
  TelegramCubit(this._mainImageCubit) : super(TelegramInitial());

  final MainImageCubit _mainImageCubit;

  void uploadToTelegram(String chatId) async {
    var state = _mainImageCubit.state;

    if (state is MainImageEmpty) {
      return;
    }

    state = state as MainImageSelected;

    final path = "${serverHost()}/api/v1/stickify/upload/$chatId";
    logger.i('Uploading sticker to telegram');
    logger.i('Path: $path');
    try {
      emit(TelegramUploadingInProgress());
      final formData = FormData.fromMap({
        'sticker': MultipartFile.fromBytes(
          state.imageEdited,
          filename: _filename,
        ),
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
