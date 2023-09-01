// ignore_for_file: file_names

import 'package:boss/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyLogoWidget extends StatelessWidget {
  final double size;

  const MyLogoWidget({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeProvider watchTheme = context.watch<ThemeProvider>();

    return Center(
      child: Container(
        width: size * 3.1,
        //height: size * 3.1,
        child: Image.asset(
          "assets/images/hat.png",
          color: watchTheme.colors.white,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
