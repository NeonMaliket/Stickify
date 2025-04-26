import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pro_image_editor/pro_image_editor.dart';
import 'package:stickify/bloc/image_uploader/image_uploader_bloc.dart';

part 'image_editor_event.dart';
part 'image_editor_state.dart';

class ImageEditorBloc extends Bloc<ImageEditorEvent, ImageEditorState> {
  ImageEditorBloc(this._context, this._imageUploaderBloc)
    : super(ImageEditorInitial()) {
    on<EditImageEvent>(onEditEvent);
    on<ResetEditImageEvent>(onResetEditImageEvent);
  }

  final BuildContext _context;
  final ImageUploaderBloc _imageUploaderBloc;

  void onResetEditImageEvent(ResetEditImageEvent event, emit) {
    emit(ImageEditorInitial());
  }

  void onEditEvent(EditImageEvent event, emit) async {
    print('Edit event');

    final imageUploaderState = _imageUploaderBloc.state;
    if (imageUploaderState is ImageUploadCompleteState) {
      final Uint8List selectedImage;
      final currentState = state;
      if (currentState is EditCompleteState) {
        selectedImage = currentState.editedImage;
      } else {
        selectedImage = imageUploaderState.file;
      }

      final result = await Navigator.push<Uint8List?>(
        _context,
        MaterialPageRoute(
          builder:
              (context) => ProImageEditor.memory(
                selectedImage,
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

      if (result != null) {
        emit(EditCompleteState(result));
      } else {
        emit(EditCompleteState(selectedImage));
      }
    }
  }
}
