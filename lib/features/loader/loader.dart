import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:stickify/bloc/loader_cubit/loader_cubit.dart';
import 'package:stickify/core/constants/paths.dart';

class Loader extends StatelessWidget {
  const Loader({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    OverlayEntry overlayEntry = OverlayEntry(
      builder:
          (context) => Material(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(backgroundPath),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(child: Lottie.asset(loaderAnimationPath)),
            ),
          ),
    );

    return BlocListener<LoaderCubit, LoaderState>(
      listener: (context, state) {
        if (state is Loading) {
          Overlay.of(context).insert(overlayEntry);
        } else {
          overlayEntry.remove();
        }
      },
      child: child,
    );
  }
}
