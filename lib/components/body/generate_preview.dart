import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_text_fields/material_text_fields.dart';
import 'package:material_text_fields/utils/form_validation.dart';
import 'package:stickify/bloc/ai_cubit/ai_cubit.dart';
import 'package:stickify/components/body/upload_select.dart';
import 'package:stickify/core/core.dart';
import 'package:stickify/core/logger.dart';
import 'package:stickify/theme/app_theme.dart';

class GeneratePreview extends StatefulWidget {
  const GeneratePreview({super.key});

  @override
  State<GeneratePreview> createState() => _GeneratePreviewState();
}

class _GeneratePreviewState extends State<GeneratePreview> {
  final TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStileSmall = context.telegramTheme().textTheme.titleSmall;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 20,
      children: [
        Text(
          'Generate Sticker with AI',
          style: context.telegramTheme().textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        Form(
          key: _formKey,
          child: MaterialTextField(
            keyboardType: TextInputType.text,
            helperText: 'Sticker Prompt',
            minLines: 1,
            maxLines: 3,
            maxLength: 50,
            style: textStileSmall,
            textInputAction: TextInputAction.next,
            prefixIcon: Icon(
              Icons.add_box_outlined,
              color: context.telegramTheme().colorScheme.primary,
            ),
            controller: _controller,
            validator: FormValidation.requiredTextField,
            theme: InputDecorationTheme(
              helperStyle: textStileSmall,
              errorStyle: textStileSmall?.copyWith(color: Colors.red),
              filled: true,
              hoverColor: Colors.green,
              focusColor: Colors.green,
              fillColor: Colors.transparent,
            ),
          ),
        ),
        SizedBox.fromSize(
          size: Size(context.vw(50), context.vw(50)),
          child: UploadSelect(
            onTap: () {
              logger.i('Generate AI');
              if (_formKey.currentState?.validate() ?? false) {
                logger.i('Prompt is Valid');
                context.read<AiCubit>().sendToAi(_controller.text);
              }
            },
            child: BlocBuilder<AiCubit, AiState>(
              builder: (context, state) {
                if (state is AiGenerated) {
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: MemoryImage(state.resource),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  );
                } else if (state is AiGenerating) {
                  return SizedBox(
                    width: 50,
                    child: CircularProgressIndicator(),
                  );
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.send_time_extension_rounded,
                      color: Colors.orange,
                    ),
                    Text('Send to AI', style: textStileSmall),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
