import 'package:new_telegram_web_app/telegram_web_app.dart';

int chatId() {
  final profile = const String.fromEnvironment("PROFILE").toLowerCase();
  return profile == "dev".toLowerCase() ? 7792645005 : TelegramWebApp.instance.initData.user.id;
}
