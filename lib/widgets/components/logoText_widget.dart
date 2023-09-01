// ignore_for_file: file_names

import 'package:flutter/material.dart';

class MyLogoTextWidget extends StatelessWidget {
  final double size;
  const MyLogoTextWidget({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size * 9,
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(size / 2),
          child: Image.asset(
            "assets/images/logo-text.png",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
