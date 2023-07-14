// ignore_for_file: file_names

import 'package:boss/providers/ThemeProvider.dart';
import 'package:boss/resources/AppDimensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PopUpInfoWidget extends StatelessWidget {
  final IconData iconPopUp;
  final String title;
  final String description;

  const PopUpInfoWidget({
    Key? key,
    required this.iconPopUp,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeProvider watchTheme = context.watch<ThemeProvider>();
    return IconButton(
      icon: Icon(
        iconPopUp,
      ),
      color: watchTheme.colors.lightPrimary,
      style: IconButton.styleFrom(
        iconSize: AppDimensions.fontSizeMedium,
        padding: const EdgeInsets.all(5),
        minimumSize: const Size(10, 10),
      ),
      onPressed: () => showDialog<String>(
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
          content: Text(
            description,
            style: TextStyle(
                fontSize: AppDimensions.fontSizeXSmall,
                color: watchTheme.colors.lightPrimary),
          ),
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
      ),
    );
  }
}
