part of 'image_uploader_bloc.dart';

@immutable
abstract class ImageUploaderEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ImageUploadEvent extends ImageUploaderEvent {}

class ImageUploaderResetEvent extends ImageUploaderEvent {}
