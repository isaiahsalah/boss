import 'package:boss/providers/ThemeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyLogoTextWidget extends StatelessWidget {
  final double size;
  const MyLogoTextWidget({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeProvider watchTheme = context.watch<ThemeProvider>();

    return Stack(
      alignment: Alignment.topRight,
      children: [
        Padding(
          padding: EdgeInsets.only(right: (size * 1.1), top: (size * 0.5)),
          child: Text(
            "Singleton",
            style: TextStyle(
              fontSize: size * 0.7,
              color: watchTheme.colors.lightPrimary,
            ),
          ),
        ),
        Text(
          "Boss",
          style: TextStyle(fontSize: size * 3, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
