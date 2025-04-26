part of 'image_uploader_bloc.dart';

@immutable
abstract class ImageUploaderState extends Equatable {}

class ImageUploaderInitial extends ImageUploaderState {
  @override
  List<Object> get props => [];
}

class ImageUploadingState extends ImageUploaderInitial {}

class ImageUploadCompleteState extends ImageUploaderInitial {
  final Uint8List file;

  ImageUploadCompleteState(this.file);

  @override
  List<Object> get props => [file];
}

class ImageUploadingErrorState extends ImageUploaderInitial {
  final String message;

  ImageUploadingErrorState(this.message);

  @override
  List<Object> get props => [message];
}
