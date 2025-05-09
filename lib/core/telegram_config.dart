import 'package:new_telegram_web_app/telegram_web_app.dart';


final profile = const String.fromEnvironment("PROFILE").toLowerCase();

bool isDev() {
  return profile.toLowerCase() == "dev".toLowerCase();
}

TelegramWebApp telegramWebApp() {
  return TelegramWebApp.instance;
}

int chatId() {
  return isDev() ? 7792645005 : TelegramWebApp.instance.initData.user.id;
}

void telegramLog(message) {
  telegramWebApp().showConfirm('Telegram Log: $message');
}
