import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stickify/bloc/image_uploader/image_uploader_bloc.dart';
import 'package:stickify/features/main_page/view/main_page.dart';
import 'package:stickify/theme/app_theme.dart';

import 'bloc/image_editor/image_editor_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'STICKIFY',
      debugShowCheckedModeBanner: false,
      theme: context.telegramTheme(),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ImageUploaderBloc()),
          BlocProvider(
            create:
                (ctx) => ImageEditorBloc(ctx, ctx.read<ImageUploaderBloc>()),
          ),
        ],
        child: const MainPage(),
      ),
    );
  }
}
