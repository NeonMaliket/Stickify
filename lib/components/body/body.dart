import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stickify/bloc/menu_cubit/menu_cubit.dart';
import 'package:stickify/components/body/generate_preview.dart';
import 'package:stickify/components/body/upload_preview.dart';
import 'package:stickify/core/core.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final PageController _controller = PageController(initialPage: 0);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final menuCubit = context.read<MenuCubit>();
    return BlocListener<MenuCubit, MenuState>(
      listener: (context, state) {
        if (state is UploadMenuItem && _controller.page != 0) {
          _controller.animateToPage(
            0,
            duration: Duration(seconds: 1),
            curve: Curves.easeInOut,
          );
        } else if (state is GenerateMenuItem && _controller.page != 1) {
          _controller.animateToPage(
            1,
            duration: Duration(seconds: 1),
            curve: Curves.easeInOut,
          );
        }
      },
      child: SizedBox(
        width: context.vw(100),
        height: context.vh(50),
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _controller,
          children: [UploadPreview(), GeneratePreview()],
        ),
      ),
    );
  }
}
