import 'package:flutter/material.dart';

class CustomColors {
  static Color appbarBlue = const Color(0xFFACBCFF);
  static ColorScheme appColorScheme = ColorScheme(
    primary: appbarBlue,
    secondary: Colors.white,
    surface: Colors.white,
    background: Colors.white,
    error: Colors.deepOrangeAccent,
    onPrimary: Colors.black,
    onSecondary: Colors.black,
    onSurface: Colors.black,
    onBackground: Colors.black,
    onError: Colors.white,
    brightness: Brightness.light,
  );
}
