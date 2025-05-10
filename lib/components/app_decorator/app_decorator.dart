import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stickify/bloc/ai_cubit/ai_cubit.dart';
import 'package:stickify/bloc/app_bloc.dart';
import 'package:stickify/bloc/main_image_cubit/main_image_cubit.dart';
import 'package:stickify/components/app_alert/app_alert.dart';
import 'package:stickify/features/loader/loader.dart';

class AppDecorator extends StatelessWidget {
  const AppDecorator({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ImageUploaderDecorator(
      child: AiDecorator(child: AppAlert(child: Loader(child: child))),
    );
  }
}

class AiDecorator extends StatelessWidget {
  const AiDecorator({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AiCubit, AiState>(
      listenWhen: _listenOnlyNewState,
      listener: (context, state) {
        if (state is AiGenerated) {
          context.read<MainImageCubit>().generate(state.resource);
        }
      },
      child: child,
    );
  }
}

class ImageUploaderDecorator extends StatelessWidget {
  const ImageUploaderDecorator({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ImageUploaderBloc, ImageUploaderState>(
      listenWhen: _listenOnlyNewState,
      listener: (context, state) {
        if (state is ImageUploadCompleteState) {
          context.read<MainImageCubit>().upload(state.file);
        }
      },
      child: child,
    );
  }
}

bool _listenOnlyNewState(final before, final current) {
  return before != current;
}
