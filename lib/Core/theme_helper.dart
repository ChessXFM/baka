import 'package:flutter/material.dart';

class ThemeHelper {
  static const Color primaryColor = Color.fromARGB(255, 40, 54, 24);
  static const Color accentColor = Color.fromARGB(255, 254, 250, 224);
  static const Color secondaryColor = Color.fromARGB(255, 188, 108, 37);
  static const Color otherSecondaryColor = Color.fromARGB(255, 221, 161, 94);

  static const Color otherprimaryColor = Color.fromARGB(255, 96, 108, 56);
  static ThemeData myTheme = ThemeData(
    elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor:
                MaterialStatePropertyAll(ThemeHelper.otherprimaryColor))),
    scaffoldBackgroundColor: ThemeHelper.accentColor,
    appBarTheme: const AppBarTheme(color: ThemeHelper.otherprimaryColor),
    brightness: Brightness.light,
    fontFamily: 'Amiri',

    focusColor: otherprimaryColor,
    highlightColor: otherprimaryColor,
    primaryColor: otherprimaryColor,
    primaryColorLight: otherprimaryColor,
    primaryColorDark: otherprimaryColor,

    //
    // primarySwatch: ,
    //
    inputDecorationTheme: const InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ThemeHelper.otherprimaryColor)),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ThemeHelper.otherprimaryColor)),
      // تخصيص الألوان هنا
      border: OutlineInputBorder(
        borderSide:
            BorderSide(color: ThemeHelper.otherprimaryColor), // لون الحدود
      ),
      focusColor: ThemeHelper.otherprimaryColor,
      hoverColor: ThemeHelper.otherprimaryColor,
      labelStyle: TextStyle(color: ThemeHelper.otherprimaryColor), // لون النص
      // hintStyle: TextStyle(color: Colors.grey), // لون النص عند الهدوء
    ),
  );
}
