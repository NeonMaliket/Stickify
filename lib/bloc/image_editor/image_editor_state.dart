part of 'image_editor_bloc.dart';

@immutable
abstract class ImageEditorState extends Equatable {
  @override
  List<Object> get props => [];
}

class ImageEditorInitial extends ImageEditorState {}

class EditInProgressState extends ImageEditorState {}

class EditCompleteState extends ImageEditorState {}

class EditErrorState extends ImageEditorState {
  final String message;

  EditErrorState(this.message);

  @override
  List<Object> get props => [message];
}
