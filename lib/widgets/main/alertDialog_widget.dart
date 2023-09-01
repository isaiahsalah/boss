// ignore_for_file: file_names

import 'package:boss/providers/theme_provider.dart';
import 'package:boss/resources/dimensions_resource.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: non_constant_identifier_names
Future ShowAlertDialog({
  required BuildContext context,
  required String title,
  required Widget content,
}) {
  ThemeProvider watchTheme = context.watch<ThemeProvider>();

  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      titlePadding: const EdgeInsets.only(
        right: AppDimensions.spacingMedium,
        left: AppDimensions.spacingMedium,
        top: AppDimensions.spacingMedium,
        bottom: AppDimensions.spacingSmall,
      ),
      contentPadding: const EdgeInsets.only(
        right: AppDimensions.spacingMedium,
        left: AppDimensions.spacingMedium,
        bottom: AppDimensions.spacingMedium,
      ),
      actionsPadding: const EdgeInsets.all(AppDimensions.spacingSmall),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
            AppDimensions.radiusSmall), // Modifica el radio de borde aquí
      ),
      backgroundColor: watchTheme.colors.primary,
      surfaceTintColor: Colors.transparent,
      contentTextStyle: const TextStyle(),
      titleTextStyle: const TextStyle(),
      title: Text(
        title,
        style: const TextStyle(fontSize: AppDimensions.fontSizeSmall),
      ),
      content: content,
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: Text(
            'OK',
            style: TextStyle(color: watchTheme.colors.white),
          ),
        ),
      ],
    ),
  );
}
