part of 'main_image_cubit.dart';

@immutable
abstract class MainImageState extends Equatable {
  @override
  List<Object> get props => [];
}

class MainImageEmpty extends MainImageState {}

class MainImageSelected extends MainImageState {
  final bool isGenerated;
  final Uint8List imageOrigin;
  final Uint8List imageEdited;

  MainImageSelected(this.imageOrigin, this.imageEdited, this.isGenerated);

  @override
  List<Object> get props => [isGenerated, imageOrigin, imageEdited];
}
