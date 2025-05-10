import 'package:new_telegram_web_app/telegram_web_app.dart';
import 'package:stickify/core/logger.dart';

final profile = const String.fromEnvironment("PROFILE").toLowerCase();

bool isDev() {
  return profile.toLowerCase() == "dev".toLowerCase();
}

TelegramWebApp telegramWebApp() {
  return TelegramWebApp.instance;
}

int chatId() {
  logger.i("Is DEV mode: ${isDev()}");
  return isDev() ? 7792645005 : TelegramWebApp.instance.initData.user.id;
}

void telegramLog(message) {
  telegramWebApp().showConfirm('Telegram Log: $message');
}
