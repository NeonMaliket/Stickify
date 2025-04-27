import 'package:flutter/material.dart';

final ThemeData telegramWebAppTheme = ThemeData(
  scaffoldBackgroundColor: Colors.black12,
  buttonTheme: ButtonThemeData(buttonColor: Colors.blue),
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.grey,
    primary: Colors.blue,
    secondary: Colors.white,
  ),
  textTheme: TextTheme(
    titleLarge: TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    titleMedium: TextStyle(
      color: Colors.white,
      fontSize: 35,
      fontWeight: FontWeight.w300,
      fontFamily: 'Lexend',
    ),
    titleSmall: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w300,
      fontFamily: 'Lexend',
    ),
  ),
);

extension TelegramThemeExtention on BuildContext {
  ThemeData telegramTheme() {
    return telegramWebAppTheme;
  }
}
