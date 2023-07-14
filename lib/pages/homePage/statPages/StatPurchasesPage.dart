// ignore_for_file: file_names

import 'package:boss/charts/BalanceChart.dart';
import 'package:boss/charts/MultiPieChart.dart';
import 'package:boss/charts/VerticalBarChartSimple.dart';
import 'package:boss/providers/LanguageProvider.dart';
import 'package:boss/providers/ThemeProvider.dart';
import 'package:boss/resources/AppDimensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatPurchasesPage extends StatelessWidget {
  const StatPurchasesPage({super.key});

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
                    .languageTexts!.pages.stats.pages!.purchases.subTitle,
                style: TextStyle(
                  fontSize: AppDimensions.fontSizeXXSmall,
                  color: watchTheme.colors.lightPrimary,
                )),
            Text(
                watchLanguage.languageTexts!.pages.stats.pages!.purchases.title,
                style: const TextStyle(
                  fontSize: AppDimensions.fontSizeSmall,
                )),
          ],
        ),
      ),
      body: ListView(
        children: const [
          SizedBox(height: 20),
          ExampleBalanceChart(),
          VerticalBarChartSimple(),
          ExampleMultiPieChart()
        ],
      ),
    );
  }
}
