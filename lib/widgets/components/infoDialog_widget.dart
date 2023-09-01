// ignore_for_file: file_names

import 'package:boss/providers/theme_provider.dart';
import 'package:boss/resources/dimensions_resource.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PopUpInfoWidget extends StatelessWidget {
  final IconData iconPopUp;
  final Color color;

  final String title;
  final Widget content;

  const PopUpInfoWidget({
    Key? key,
    required this.iconPopUp,
    required this.color,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeProvider watchTheme = context.watch<ThemeProvider>();
    return IconButton(
        onPressed: () {
          showDialog<String>(
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
                borderRadius: BorderRadius.circular(AppDimensions
                    .radiusSmall), // Modifica el radio de borde aquí
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
        },
        icon: Icon(
          Icons.info_rounded,
          size: AppDimensions.spacingLong,
        ));
  }
}


/*GestureDetector(
      child: Icon(
        Icons.info_rounded,
        color: color,
        size: AppDimensions.spacingMedium * 1.5,
      ),
      onTap: () => showDialog<String>(
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
      ),
    )*/


























/*
 PopUpInfoWidget ({
  required BuildContext context,
  required IconData iconPopUp,
  required String title,
  required Widget content,}
) {
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

*/