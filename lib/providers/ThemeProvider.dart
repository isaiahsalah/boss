import 'package:flutter/material.dart';

class ColorPalette {
  Color primary;
  Color lightPrimary;
  Color lightBackground;
  Color background;
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
    required this.alternative,
    required this.white,
    required this.active,
    required this.red,
    required this.green,
  });
}

class ThemeProvider with ChangeNotifier {
  ColorPalette _colorPaletteLight = ColorPalette(
    primary: Color(0xFF3B5A72),
    lightPrimary: Color(0xFFF2E2D2),
    lightBackground: Color(0xFFA7B5BF),
    background: Color(0xFF627B8E),
    alternative: Color(0xFFD4764E),
    white: Color(0xFFFFFFFF),
    active: Color(0xFFD4764E),
    red: Color(0xFFEF927F),
    green: Color(0xFF9EDBA2),
  );

  ColorPalette _colorPaletteDark = ColorPalette(
    primary: Color(0xFF3B5A72),
    lightPrimary: Color(0xFFA7B5BF),
    lightBackground: Color(0xFF627B8E),
    background: Color(0xFF273C4C),
    alternative: Color(0xFFF2E2D2),
    white: Color(0xFFFFFFFF),
    active: Color(0xFFD4764E),
    red: Color(0xFFEF927F),
    green: Color(0xFF9EDBA2),
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
