import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stickify/bloc/image_uploader/image_uploader_bloc.dart';
import 'package:stickify/core/core.dart';

class UploadSelect extends StatelessWidget {
  const UploadSelect({super.key});

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.all(Radius.circular(20));
    return Material(
      color: Colors.white.withAlpha(70),
      borderRadius: borderRadius,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: () {
          context.read<ImageUploaderBloc>().add(ImageUploadEvent());
        },
        child: Container(
          width: context.vw(70),
          height: context.vw(70),
          alignment: Alignment.center,
          child: Icon(Icons.add, size: 60),
        ),
      ),
    );
  }
}
