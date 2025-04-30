import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:stickify/core/logger.dart';

part 'alert_state.dart';

class AlertCubit extends Cubit<AlertState> {
  AlertCubit() : super(AlertInitial());


  void showError(final String message) {
    logger.i('Showing error');
    emit(ShowError(message));
  }

  void hideError() {
    logger.i('Hiding error');
    emit(HideError());
  }
}
