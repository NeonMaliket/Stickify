import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pro_image_editor/pro_image_editor.dart';
import 'package:stickify/bloc/ai_cubit/ai_cubit.dart';
import 'package:stickify/bloc/image_uploader/image_uploader_bloc.dart';
import 'package:stickify/bloc/menu_cubit/menu_cubit.dart';
import 'package:stickify/core/logger.dart';

part 'image_editor_event.dart';
part 'image_editor_state.dart';

class ImageEditorBloc extends Bloc<ImageEditorEvent, ImageEditorState> {
  ImageEditorBloc(
    this._context,
    this._aiCubit,
    this._menuCubit,
    this._imageUploaderBloc,
  ) : super(ImageEditorInitial()) {
    on<EditImageEvent>(onEditEvent);
  }

  final AiCubit _aiCubit;
  final MenuCubit _menuCubit;
  final BuildContext _context;
  final ImageUploaderBloc _imageUploaderBloc;

  void onEditEvent(EditImageEvent event, emit) async {
    logger.i('Edit event');

    final imageUploaderState = _imageUploaderBloc.state;
    Uint8List? selectedImage;

    final aiState = _aiCubit.state;
    final currentState = state;

    if (_menuCubit.isGenerateItem() && aiState is AiGenerated) {
      selectedImage = aiState.resource;
    } else if (_menuCubit.isUploadItem()) {
      if (currentState is EditCompleteState &&
          currentState.menuIndex == _menuCubit.currentIndex()) {
        selectedImage = currentState.editedImage;
      } else if (imageUploaderState is ImageUploadCompleteState) {
        selectedImage = imageUploaderState.file;
      }
    } else {
      if (currentState is EditCompleteState) {
        selectedImage = currentState.editedImage;
      }
    }

    if (selectedImage == null) {
      return;
    }

    final result = await Navigator.push<Uint8List?>(
      _context,
      MaterialPageRoute(
        builder:
            (context) => ProImageEditor.memory(
              selectedImage ?? Uint8List(0),
              configs: ProImageEditorConfigs(
                designMode: ImageEditorDesignMode.cupertino,
                imageGeneration: ImageGenerationConfigs(
                  outputFormat: OutputFormat.png,
                ),
              ),
              callbacks: ProImageEditorCallbacks(
                onCompleteWithParameters: (params) async {
                  if (_menuCubit.state is GenerateMenuItem) {
                    _menuCubit.upload();
                  }
                  Navigator.pop(context, params.image);
                },
              ),
            ),
      ),
    );

    if (result != null) {
      emit(EditCompleteState(result, _menuCubit.state.index));
    } else {
      emit(EditCompleteState(selectedImage, _menuCubit.state.index));
    }
  }
}
