import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stickify/bloc/app_bloc.dart';
import 'package:stickify/components/body/upload_select.dart';
import 'package:stickify/core/core.dart';
import 'package:stickify/theme/app_theme.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Preview', style: context.telegramTheme().textTheme.titleMedium),
        SizedBox(
          width: context.vw(100),
          height: context.vw(100),
          child: BlocBuilder<ImageUploaderBloc, ImageUploaderState>(
            builder: (_, imageUploaderState) {
              return BlocBuilder<ImageEditorBloc, ImageEditorState>(
                builder: (_, imageEditorState) {
                  Uint8List? imageBytes;

                  if (imageUploaderState is ImageUploadCompleteState &&
                      imageUploaderState.file.isNotEmpty) {
                    imageBytes = imageUploaderState.file;
                  }
                  if (imageEditorState is EditCompleteState &&
                      imageEditorState.editedImage.isNotEmpty) {
                    imageBytes = imageEditorState.editedImage;
                  }

                  if (imageBytes != null) {
                    return Image.memory(imageBytes, fit: BoxFit.contain);
                  }
                  return UploadSelect();
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
