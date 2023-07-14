// ignore_for_file: file_names

import 'package:boss/providers/ThemeProvider.dart';
import 'package:boss/resources/AppDimensions.dart';
import 'package:boss/widgets/components/MyPopUpInfoWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyCardWidget extends StatelessWidget {
  final String title;
  final String description;
  final bool footer;
  final bool header;

  final Widget widgetContend;

  const MyCardWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.footer,
    required this.header,
    required this.widgetContend,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeProvider watchTheme = context.watch<ThemeProvider>();
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600.0),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.spacingMedium,
              vertical: 0,
            ),
            child: Column(
              children: [
                Card(
                  surfaceTintColor: Colors.transparent,
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(AppDimensions.spacingMedium),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        header
                            ? MyTitleWidgetWidget(watchTheme: watchTheme)
                            : const SizedBox(),
                        const SizedBox(height: AppDimensions.spacingSmall),
                        widgetContend,
                        const SizedBox(height: AppDimensions.spacingSmall),
                        footer
                            ? MyButtonWidgetWidget(watchTheme: watchTheme)
                            : const SizedBox(
                                height: 0,
                              )
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: 20,
                  color: watchTheme.colors.lightBackground,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget MyTitleWidgetWidget({required ThemeProvider watchTheme}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                color: watchTheme.colors.white,
                fontSize: AppDimensions.fontSizeSmall,
              ),
            ),
            PopUpInfoWidget(
              iconPopUp: Icons.info,
              title: title,
              description: description,
            ),
          ],
        ),
        Divider(
          height: 0,
          color: watchTheme.colors.lightBackground,
        ),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Widget MyButtonWidgetWidget({required ThemeProvider watchTheme}) {
    return Column(
      children: [
        Divider(
          height: 0,
          color: watchTheme.colors.lightBackground,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            TextButton(
              style: TextButton.styleFrom(),
              child: Text(
                "Ver Más",
                style: TextStyle(
                  color: watchTheme.colors.lightPrimary,
                  fontSize: AppDimensions.fontSizeSmall,
                ),
              ),
              onPressed: () {},
            )
          ],
        ),
      ],
    );
  }
}
