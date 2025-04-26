import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stickify/bloc/app_bloc.dart';
import 'package:stickify/core/core.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Preview',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Container(
          width: context.vw(70),
          height: context.vw(70),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.grey.withAlpha(50),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: BlocBuilder<ImageUploaderBloc, ImageUploaderState>(
            builder: (_, imageUploaderState) {
              return BlocBuilder<ImageEditorBloc, ImageEditorState>(
                builder: (_, imageEditorState) {
                  Uint8List? imageBytes;

                  if (imageEditorState is EditCompleteState &&
                      imageEditorState.editedImage.isNotEmpty) {
                    imageBytes = imageEditorState.editedImage;
                  } else if (imageUploaderState is ImageUploadCompleteState &&
                      imageUploaderState.file.isNotEmpty) {
                    imageBytes = imageUploaderState.file;
                  }

                  if (imageBytes != null) {
                    return Image.memory(imageBytes, fit: BoxFit.contain);
                  }
                  return Icon(Icons.add, size: 60);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
