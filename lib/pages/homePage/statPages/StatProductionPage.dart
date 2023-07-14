// ignore_for_file: file_names

import 'package:boss/charts/MultiPieChart.dart';
import 'package:boss/charts/PieChart.dart';
import 'package:boss/charts/ResumeBoxesChart.dart';
import 'package:boss/providers/LanguageProvider.dart';
import 'package:boss/providers/ThemeProvider.dart';
import 'package:boss/resources/AppDimensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatProductionPage extends StatelessWidget {
  const StatProductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    LanguageProvider watchLanguage = context.watch<LanguageProvider>();
    ThemeProvider watchTheme = context.watch<ThemeProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                watchLanguage
                    .languageTexts!.pages.stats.pages!.production.subTitle,
                style: TextStyle(
                  fontSize: AppDimensions.fontSizeXXSmall,
                  color: watchTheme.colors.lightPrimary,
                )),
            Text(
                watchLanguage
                    .languageTexts!.pages.stats.pages!.production.title,
                style: const TextStyle(
                  fontSize: AppDimensions.fontSizeSmall,
                )),
          ],
        ),
      ),
      body: ListView(
        children: const [
          SizedBox(height: 20),
          ResumeBoxesChart(),
          ExamplePieChart(),
          ExampleMultiPieChart()
        ],
      ),
    );
  }
}
