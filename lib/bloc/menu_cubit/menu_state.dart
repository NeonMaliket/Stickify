part of 'menu_cubit.dart';

@immutable
abstract class MenuState extends Equatable {
  final int index;

  const MenuState(this.index);

  @override
  List<Object> get props => [index];
}

class UploadMenuItem extends MenuState {
  const UploadMenuItem() : super(0);
}

class GenerateMenuItem extends MenuState {
  const GenerateMenuItem() : super(1);
}
