import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:stickify/core/logger.dart';

part 'menu_state.dart';

class MenuCubit extends Cubit<MenuState> {
  MenuCubit() : super(UploadMenuItem());

  void upload() {
    emit(UploadMenuItem());
  }

  void generate() {
    emit(GenerateMenuItem());
  }

  void followBy(itemIndex) {
    logger.i('Moving menu to: $itemIndex');
    if (itemIndex == this.state.index) {
      logger.w(
        'Current state is already: ${this.state}. State wont be changed.',
      );
    }
    final actions = [UploadMenuItem(), GenerateMenuItem()];

    var state = actions.firstWhere((item) => item.index == itemIndex);

    emit(state);
  }

  int currentIndex() {
    return state.index;
  }
}
