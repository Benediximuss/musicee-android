import 'package:flutter/material.dart';

final class ColorManager {
  const ColorManager._();

  static const Color colorPrimary = Color.fromARGB(255, 233, 142, 141);
  // static const Color colorSecondary = Color.fromARGB(255, 151, 30, 28);

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

  static const MaterialColor lighterSwatch = MaterialColor(
    0xFFE98E8D,
    {
      50: Color(0xffffffff),
      100: Color(0xFFfdf4f4),
      200: Color(0xFFfbe8e8),
      300: Color(0xFFf8dddd),
      400: Color(0xFFf6d2d1),
      500: Color(0xfff4c7c6),
      600: Color(0xFFf2bbbb),
      700: Color(0xFFf0b0af),
      800: Color(0xFFeda5a4),
      900: Color(0xFFeb9998),
    },
  );

  static const MaterialColor darkerSwatch = MaterialColor(
    0xFFE98E8D,
    {
      50: Color(0xFFd2807f),
      100: Color(0xFFba7271),
      200: Color(0xFFa36363),
      300: Color(0xFF8c5555),
      400: Color(0xFF754747),
      500: Color(0xFF5d3938),
      600: Color(0xFF462b2a),
      700: Color(0xFF2f1c1c),
      800: Color(0xFF170e0e),
      900: Color(0xFF000000),
    },
  );
}
