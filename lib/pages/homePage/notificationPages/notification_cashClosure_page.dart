// ignore_for_file: file_names

import 'package:boss/providers/theme_provider.dart';
import 'package:boss/resources/dimensions_resource.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationCashClosurePage extends StatelessWidget {
  const NotificationCashClosurePage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider watchTheme = context.watch<ThemeProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Titulo",
                style: TextStyle(
                  fontSize: AppDimensions.fontSizeXXSmall,
                  color: watchTheme.colors.lightPrimary,
                )),
            const Text("Item",
                style: TextStyle(
                  fontSize: AppDimensions.fontSizeSmall,
                )),
          ],
        ),
      ),
    );
  }
}
