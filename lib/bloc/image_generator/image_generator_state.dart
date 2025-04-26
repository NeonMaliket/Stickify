part of 'image_generator_bloc.dart';

@immutable
abstract class ImageGeneratorState extends Equatable {
  @override
  List<Object> get props => [];
}

class ImageGeneratorInitial extends ImageGeneratorState {}

class ImageGenerationLoadingState extends ImageGeneratorState {}

class ImageGenerationSuccessState extends ImageGeneratorState {
  final Uint8List generatedImage;

  ImageGenerationSuccessState(this.generatedImage);

  @override
  List<Object> get props => [generatedImage];
}

class ImageGenerationErrorState extends ImageGeneratorState {
  final String error;

  ImageGenerationErrorState(this.error);

  @override
  List<Object> get props => [error];
}

class GenerateImageModalState extends ImageGeneratorState {
  final bool isOpen;

  GenerateImageModalState(this.isOpen);

  @override
  List<Object> get props => [isOpen];
}
