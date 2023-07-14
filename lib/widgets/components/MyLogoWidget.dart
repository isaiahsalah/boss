// ignore_for_file: file_names

import 'package:boss/providers/ThemeProvider.dart';
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

    return SizedBox(
      width: size * 3.1,
      height: size * 3.1,
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(size / 3),
          child: Container(
            color: watchTheme.colors.lightBackground,
            width: size * 3.1,
            height: size * 3.1,
            child: Padding(
              padding: EdgeInsets.all(size / 2.5),
              child: Image.asset(
                "assets/images/logo.png",
                color: watchTheme.colors.white,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
