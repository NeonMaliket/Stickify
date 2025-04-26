part of 'image_editor_bloc.dart';

@immutable
abstract class ImageEditorEvent extends Equatable {}

class ResetEditImageEvent extends ImageEditorEvent {
  @override
  List<Object> get props => [];
}

class EditImageEvent extends ImageEditorEvent {
  final BuildContext context;

  EditImageEvent(this.context);

  @override
  List<Object> get props => [context];
}
