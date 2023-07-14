import 'package:boss/charts/BalanceChart.dart';
import 'package:boss/charts/LineChart.dart';
import 'package:boss/charts/MonthVerticalBarChart.dart';
import 'package:boss/providers/LanguageProvider.dart';
import 'package:boss/providers/ThemeProvider.dart';
import 'package:boss/resources/AppDimensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatHumanResourcePage extends StatelessWidget {
  const StatHumanResourcePage({super.key});

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
                    .languageTexts!.pages.stats.pages!.humanResources.subTitle,
                style: TextStyle(
                  fontSize: AppDimensions.fontSizeXXSmall,
                  color: watchTheme.colors.lightPrimary,
                )),
            Text(
                watchLanguage
                    .languageTexts!.pages.stats.pages!.humanResources.title,
                style: TextStyle(
                  fontSize: AppDimensions.fontSizeSmall,
                )),
          ],
        ),
      ),
      body: ListView(
        children: [
          SizedBox(height: 20),
          ExampleBalanceChart(),
          ExampleMonthVerticalBarChart(),
          ExampleLineChart(),
        ],
      ),
    );
  }
}
