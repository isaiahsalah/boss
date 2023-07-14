// ignore_for_file: file_names

import 'package:boss/providers/ThemeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyListTileGeneralWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget trailing;

  const MyListTileGeneralWidget({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeProvider watchTheme = context.watch<ThemeProvider>();
    return ListTile(
      title: Text(title),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: watchTheme.colors.lightPrimary,
        ),
      ),
      trailing: trailing,
    );
  }
}
