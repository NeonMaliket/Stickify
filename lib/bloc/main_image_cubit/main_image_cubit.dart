import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:stickify/core/logger.dart';

part 'main_image_state.dart';

class MainImageCubit extends Cubit<MainImageState> {
  MainImageCubit() : super(MainImageEmpty());

  void upload(Uint8List image) {
    logger.i('Uploading image');
    emit(MainImageSelected(image, image, false));
  }

  void generate(Uint8List image) {
    logger.i('Generated image');
    emit(MainImageSelected(image, image, true));
  }

  void update(Uint8List updatedImage) {
    logger.i('Updating image');
    if (state is MainImageSelected) {
      final MainImageSelected local = state as MainImageSelected;
      emit(
        MainImageSelected(local.imageOrigin, updatedImage, local.isGenerated),
      );
    }
  }
}
