import 'dart:async';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'image_generator_event.dart';
part 'image_generator_state.dart';

class ImageGeneratorBloc
    extends Bloc<ImageGeneratorEvent, ImageGeneratorState> {
  ImageGeneratorBloc() : super(ImageGeneratorInitial()) {
    on<GenerateImageEvent>(_onGenerateImageEvent);
  }

  Future<void> _onGenerateImageEvent(
    GenerateImageEvent event,
    Emitter<ImageGeneratorState> emit,
  ) async {
    print('_onGenerateImageEvent');
    print('prompt: ${event.prompt}');
  }
}
