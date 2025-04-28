part of 'ai_cubit.dart';

@immutable
abstract class AiState extends Equatable {
  @override
  List<Object> get props => [];
}

class AiInitial extends AiState {}

class AiGenerate extends AiState {
  final String prompt;

  AiGenerate(this.prompt);

  @override
  List<Object> get props => [prompt];
}

class AiGenerating extends AiState {}

class AiGenerated extends AiState {
  final Uint8List resource;

  AiGenerated(this.resource);

  @override
  List<Object> get props => [resource];
}

class AiGenerationError extends AiState {
  final String message;

  AiGenerationError(this.message);

  @override
  List<Object> get props => [message];
}
