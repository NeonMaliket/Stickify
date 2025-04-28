import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stickify/bloc/ai_cubit/ai_cubit.dart';
import 'package:stickify/bloc/image_uploader/image_uploader_bloc.dart';
import 'package:stickify/bloc/menu_cubit/menu_cubit.dart';
import 'package:stickify/theme/app_theme.dart';

import 'bloc/image_editor/image_editor_bloc.dart';
import 'bloc/image_generator/image_generator_bloc.dart';
import 'bloc/telegram_cubit/telegram_cubit.dart';
import 'features/main_page/view/main_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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

          BlocProvider(create: (_) => ImageGeneratorBloc()),
          BlocProvider(create: (_) => MenuCubit()),
          BlocProvider(create: (_) => AiCubit()),

          BlocProvider(
            create:
                (ctx) => ImageEditorBloc(
                  ctx,
                  ctx.read<ImageUploaderBloc>(),
                  ctx.read<AiCubit>(),
                  ctx.read<MenuCubit>(),
                ),
          ),

          BlocProvider(
            create:
                (ctx) => TelegramCubit(
                  ctx.read<ImageEditorBloc>(),
                  ctx.read<AiCubit>(),
                  ctx.read<MenuCubit>(),
                  ctx.read<ImageUploaderBloc>(),
                ),
          ),
        ],
        child: const MainPage(),
      ),
    );
  }
}
