part of 'image_uploader_bloc.dart';

@immutable
abstract class ImageUploaderEvent extends Equatable {}

class ImageUploadEvent extends ImageUploaderEvent {
  @override
  List<Object> get props => [];
}
