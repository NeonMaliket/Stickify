import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dropdown_alert/dropdown_alert.dart';
import 'package:stickify/bloc/ai_cubit/ai_cubit.dart';
import 'package:stickify/bloc/image_uploader/image_uploader_bloc.dart';
import 'package:stickify/bloc/menu_cubit/menu_cubit.dart';
import 'package:stickify/theme/app_theme.dart';

import 'bloc/alert_cubit/alert_cubit.dart';
import 'bloc/image_editor/image_editor_bloc.dart';
import 'bloc/invoice_cubit/invoice_cubit.dart';
import 'bloc/loader_cubit/loader_cubit.dart';
import 'bloc/main_image_cubit/main_image_cubit.dart';
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
      builder: (context, child) => Stack(children: [child!, DropdownAlert()]),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => LoaderCubit()),
          BlocProvider(create: (_) => AlertCubit()),

          BlocProvider(create: (_) => ImageUploaderBloc()),

          BlocProvider(create: (_) => MenuCubit()),
          BlocProvider(create: (ctx) => MainImageCubit()),

          BlocProvider(create: (ctx) => AiCubit(ctx.read<LoaderCubit>())),

          BlocProvider(
            create:
                (ctx) => InvoiceCubit(
                  ctx.read<LoaderCubit>(),
                  ctx.read<AlertCubit>(),
                ),
          ),

          BlocProvider(
            create: (ctx) => ImageEditorBloc(ctx, ctx.read<MainImageCubit>()),
          ),

          BlocProvider(
            create: (ctx) => TelegramCubit(ctx.read<MainImageCubit>()),
          ),
        ],
        child: const MainPage(),
      ),
    );
  }
}
