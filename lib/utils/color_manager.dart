import 'package:flutter/material.dart';

final class ColorManager {
  const ColorManager._();

  static const Color colorPrimary = Color.fromARGB(255, 233, 142, 141);
  static const Color colorSecondary = Color.fromARGB(255, 151, 30, 28);

  static const Color colorBG = Color.fromARGB(255, 253, 240, 240);

  static const Color colorAppBarText = Color.fromARGB(170, 0, 0, 0);

  static const MaterialColor swatchPrimary = MaterialColor(
    0xFFE98E8D,
    {
      50: Color(0xFFFFF5F5),
      100: Color(0xFFFFE0E0),
      200: Color(0xFFFCB9B8),
      300: Color(0xFFFA8F8E),
      400: Color(0xFFF96B6A),
      500: Color(0xFFE98E8D),
      600: Color(0xFFD17E7D),
      700: Color(0xFFB36B6A),
      800: Color(0xFF944A49),
      900: Color(0xFF7A3635),
    },
  );
}
