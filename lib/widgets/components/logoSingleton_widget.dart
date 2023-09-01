// ignore_for_file: file_names

import 'package:boss/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MyLogoSingletonWidget extends StatelessWidget {
  final double size;

  const MyLogoSingletonWidget({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeProvider watchTheme = context.watch<ThemeProvider>();

    return Opacity(
      opacity: 0.2,
      child: SizedBox(
        //width: size * 3.1,
        height: size * 1,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: size * 0.9,
                height: size * 0.9,
                child: Padding(
                  padding: EdgeInsets.all(size / 4.5),
                  child: Image.asset(
                    "assets/images/logo.png",
                    color: watchTheme.colors.white,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
