part of 'alert_cubit.dart';

@immutable
abstract class AlertState extends Equatable {
  @override
  List<Object> get props => [];
}

class AlertInitial extends AlertState {}

class ShowError extends AlertState {
  final String message;

  ShowError(this.message);

  @override
  List<Object> get props => [message];
}

class HideError extends AlertState {}
