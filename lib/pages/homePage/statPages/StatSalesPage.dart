import 'package:boss/charts/HorizontalBarChart.dart';
import 'package:boss/charts/PieChart.dart';
import 'package:boss/providers/LanguageProvider.dart';
import 'package:boss/providers/ThemeProvider.dart';
import 'package:boss/resources/AppDimensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatSalesPage extends StatelessWidget {
  const StatSalesPage({super.key});

  @override
  Widget build(BuildContext context) {
    LanguageProvider watchLanguage = context.watch<LanguageProvider>();
    ThemeProvider watchTheme = context.watch<ThemeProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(watchLanguage.languageTexts!.pages.stats.pages!.sales.subTitle,
                style: TextStyle(
                  fontSize: AppDimensions.fontSizeXXSmall,
                  color: watchTheme.colors.lightPrimary,
                )),
            Text(watchLanguage.languageTexts!.pages.stats.pages!.sales.title,
                style: TextStyle(
                  fontSize: AppDimensions.fontSizeSmall,
                )),
          ],
        ),
      ),
      body: ListView(
        children: [
          SizedBox(height: 20),
          ExamplePieChart(),
          ExampleHorizontalBarChart()
        ],
      ),
    );
  }
}
