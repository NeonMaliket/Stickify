import 'package:bloc/bloc.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';
import 'package:meta/meta.dart';
import 'package:stickify/core/logger.dart';

part 'loader_state.dart';

class LoaderCubit extends Cubit<LoaderState> {
  LoaderCubit() : super(LoaderInitial());

  void loading() {
    logger.i('Loading');
    emit(Loading());
  }

  void loaded() {
    logger.i('Loaded');
    emit(Loaded());
  }

}

