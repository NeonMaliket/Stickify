part of 'telegram_cubit.dart';

@immutable
abstract class TelegramState extends Equatable {
  @override
  List<Object> get props => [];
}

class TelegramInitial extends TelegramState {}

class TelegramUploadingInProgress extends TelegramState {}

class TelegramUploaded extends TelegramState {}

class TelegramUploadError extends TelegramState {
  final String message;

  TelegramUploadError(this.message);

  @override
  List<Object> get props => [message];
}
