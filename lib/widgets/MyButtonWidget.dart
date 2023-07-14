// ignore_for_file: file_names

import 'package:boss/resources/AppDimensions.dart';
import 'package:flutter/material.dart';

class MyButtonWidget extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final Color color;

  const MyButtonWidget({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FilledButton(
        style: FilledButton.styleFrom(
          elevation: AppDimensions.elevationSmall,
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
          ),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spacingSmall),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: AppDimensions.fontSizeXSmall,
            ),
          ),
        ),
      ),
    );
  }
}
