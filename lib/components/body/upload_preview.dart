import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stickify/bloc/app_bloc.dart';
import 'package:stickify/bloc/main_image_cubit/main_image_cubit.dart';
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
          child: BlocBuilder<MainImageCubit, MainImageState>(
            builder: (_, imageState) {
              return UploadSelect(
                onTap: () {
                  context.read<ImageUploaderBloc>().add(ImageUploadEvent());
                },
                child:
                    (imageState is MainImageSelected)
                        ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            image: DecorationImage(
                              image: MemoryImage(imageState.imageEdited),
                            ),
                          ),
                        )
                        : Icon(Icons.add, size: 100, color: Colors.black38),
              );
            },
          ),
        ),
      ],
    );
  }
}
