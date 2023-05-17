import 'package:flutter/material.dart';

class Palette {
  static const MaterialColor orangeTheme = MaterialColor(
    0xffffcdc1, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color.fromRGBO(255, 112, 78, 0.1), //10%
      100: Color.fromRGBO(255, 112, 78, 0.2), //20%
      200: Color.fromRGBO(255, 112, 78, 0.3), //30%
      300: Color.fromRGBO(255, 112, 78, 0.4), //40%
      400: Color.fromRGBO(255, 112, 78, 0.5), //50%
      500: Color.fromRGBO(255, 112, 78, 0.6), //60%
      600: Color.fromRGBO(255, 112, 78, 0.7), //70%
      700: Color.fromRGBO(255, 112, 78, 0.8), //80%
      800: Color.fromRGBO(255, 112, 78, 0.9), //90%
      900: Color.fromRGBO(255, 112, 78, 1), //100%
    },
  );

  static const Color darkGrey = Color(0xFF595959);
  static const Color whiteGrey = Color(0xFF989898);
  static const Color backgroundGrey = Color(0xFFEBEBEB);
  static const Color orangePrimary = Color(0xFFFF704E);
  static const Color yellow = Color(0xFFFFC94E);
  static const Color blue = Color(0xFF3495EF);
  static const Color lightBlue = Color(0xFF03A9F4);
  static const Color green = Color.fromRGBO(62, 181, 74, 0.75);
}
