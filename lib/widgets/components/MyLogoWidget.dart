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

    return Container(
      width: size * 3.1,
      height: size * 3.1,
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(500),
          child: Image.asset(
            "assets/images/theStrokesAlt.jpg",
            width: size * 3.1,
            height: size * 3.1,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
