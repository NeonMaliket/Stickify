part of 'image_generator_bloc.dart';

@immutable
abstract class ImageGeneratorEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GenerateImageEvent extends ImageGeneratorEvent {
  final String prompt;

  GenerateImageEvent(this.prompt);

  @override
  List<Object> get props => [];
}
