import 'package:new_telegram_web_app/telegram_web_app.dart';


final profile = const String.fromEnvironment("PROFILE").toLowerCase();

bool isDev() {
  return profile.toLowerCase() == "dev".toLowerCase();
}



TelegramWebApp telegramWebApp() {
  return isDev() ? TelegramWebAppFake() : TelegramWebApp.instance;
}

int chatId() {
  return isDev() ? 7792645005 : TelegramWebApp.instance.initData.user.id;
}
