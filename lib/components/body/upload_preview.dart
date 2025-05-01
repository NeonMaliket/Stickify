import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stickify/bloc/app_bloc.dart';
import 'package:stickify/components/body/upload_select.dart';
import 'package:stickify/core/core.dart';
import 'package:stickify/theme/app_theme.dart';

class UploadPreview extends StatelessWidget {
  const UploadPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Preview', style: context.telegramTheme().textTheme.titleMedium),
        SizedBox(
          width: context.vw(50),
          height: context.vw(50),
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

                  return UploadSelect(
                    onTap: () {
                      context.read<ImageUploaderBloc>().add(ImageUploadEvent());
                    },
                    child:
                        (imageBytes != null)
                            ? Image.memory(imageBytes, fit: BoxFit.contain)
                            : Icon(Icons.add, size: 100, color: Colors.black38),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
