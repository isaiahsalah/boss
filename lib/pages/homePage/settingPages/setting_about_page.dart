// ignore_for_file: file_names

import 'package:boss/providers/language_provider.dart';
import 'package:boss/providers/theme_provider.dart';
import 'package:boss/resources/data_resource.dart';
import 'package:boss/resources/dimensions_resource.dart';
import 'package:boss/widgets/components/listTileGeneral_widget.dart';
import 'package:boss/widgets/components/logoText_widget.dart';
import 'package:boss/widgets/components/logo_widget.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider watchTheme = context.watch<ThemeProvider>();
    LanguageProvider watchLanguage = context.watch<LanguageProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                watchLanguage
                    .languageTexts!.pages.settings.pages.about.subTitle,
                style: TextStyle(
                  fontSize: AppDimensions.fontSizeXXSmall,
                  color: watchTheme.colors.lightPrimary,
                )),
            Text(watchLanguage.languageTexts!.pages.settings.pages.about.title,
                style: const TextStyle(
                  fontSize: AppDimensions.fontSizeSmall,
                )),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingMedium),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const MyLogoWidget(size: 60),
            const MyLogoTextWidget(size: 20),
            Container(
              decoration: BoxDecoration(
                  color: watchTheme.colors.background,
                  borderRadius:
                      BorderRadius.circular(AppDimensions.spacingSmall)),
              child: Column(
                children: watchLanguage
                    .languageTexts!.pages.settings.pages.about.options
                    .mapIndexed((i, item) => MyListTileGeneralWidget(
                          title: item.title,
                          subtitle: item.subTitle,
                          trailing: AppData.myListMenuSettingAbout[i]
                              ["trailing"],
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
