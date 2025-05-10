import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pro_image_editor/pro_image_editor.dart';
import 'package:stickify/bloc/main_image_cubit/main_image_cubit.dart';
import 'package:stickify/core/logger.dart';

part 'image_editor_event.dart';
part 'image_editor_state.dart';

class ImageEditorBloc extends Bloc<ImageEditorEvent, ImageEditorState> {
  ImageEditorBloc(this._context, this._mainImageCubit)
    : super(ImageEditorInitial()) {
    on<EditImageEvent>(onEditEvent);
  }

  final BuildContext _context;
  final MainImageCubit _mainImageCubit;

  void onEditEvent(EditImageEvent event, emit) async {
    logger.i('Edit event');
    MainImageState mainImageState = _mainImageCubit.state;

    if (mainImageState is MainImageEmpty) {
      return;
    }

    mainImageState = mainImageState as MainImageSelected;

    final image = mainImageState.imageEdited;

    final result = await Navigator.push<Uint8List?>(
      _context,
      MaterialPageRoute(
        builder:
            (context) => ProImageEditor.memory(
              image,
              configs: ProImageEditorConfigs(
                designMode: ImageEditorDesignMode.cupertino,
                imageGeneration: ImageGenerationConfigs(
                  outputFormat: OutputFormat.png,
                ),
              ),
              callbacks: ProImageEditorCallbacks(
                onCompleteWithParameters: (params) async {
                  Navigator.pop(context, params.image);
                },
              ),
            ),
      ),
    );

    emit(EditCompleteState());
    _mainImageCubit.update(result ?? mainImageState.imageEdited);
  }
}
