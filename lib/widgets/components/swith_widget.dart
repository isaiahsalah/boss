// ignore_for_file: file_names

import 'package:boss/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MySwitchWidget extends StatelessWidget {
  final bool value;
  final Function(bool) onChanged;
  const MySwitchWidget({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeProvider watchTheme = context.watch<ThemeProvider>();
    return Switch(
        activeColor: watchTheme.colors.white,
        activeTrackColor: watchTheme.colors.lightPrimary,
        inactiveThumbColor: watchTheme.colors.primary,
        inactiveTrackColor: watchTheme.colors.lightBackground,
        trackOutlineColor: MaterialStateProperty.all<Color>(Colors.transparent),
        value: value,
        onChanged: onChanged);
  }
}
