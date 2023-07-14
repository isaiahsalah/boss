// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ColorPalette {
  Color primary;
  Color lightPrimary;
  Color lightBackground;
  Color background;
  Color backgroundAlt;

  Color alternative;
  Color white;
  Color active;
  Color red;
  Color green;

  ColorPalette({
    required this.primary,
    required this.lightPrimary,
    required this.lightBackground,
    required this.background,
    required this.backgroundAlt,
    required this.alternative,
    required this.white,
    required this.active,
    required this.red,
    required this.green,
  });
}

class ThemeProvider with ChangeNotifier {
  final ColorPalette _colorPaletteLight = ColorPalette(
    primary: const Color(0xFF3B5A72),
    lightPrimary: const Color(0xFFF2E2D2),
    lightBackground: const Color(0xFFA7B5BF),
    background: const Color(0xFF627B8E),
    backgroundAlt: const Color(0xFF627B8E),
    alternative: const Color(0xFFD4764E),
    white: const Color(0xFFFFFFFF),
    active: const Color(0xFFD4764E),
    red: const Color(0xFFEF927F),
    green: const Color(0xFF9EDBA2),
  );

  final ColorPalette _colorPaletteDark = ColorPalette(
    primary: const Color(0xFF3B5A72),
    lightPrimary: const Color(0xFFA7B5BF),
    lightBackground: const Color(0xFF627B8E),
    background: const Color(0xFF273C4C),
    backgroundAlt: const Color(0xff1B2A37),
    alternative: const Color(0xFFF2E2D2),
    white: const Color(0xFFFFFFFF),
    active: const Color(0xFFD4764E),
    red: const Color(0xFFEF927F),
    green: const Color(0xFF9EDBA2),
  );

  bool _isDarkTheme = true;
  bool get isDarkTheme => _isDarkTheme;
  ColorPalette get colors =>
      _isDarkTheme ? _colorPaletteDark : _colorPaletteLight;
  void updateColors() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }
}
