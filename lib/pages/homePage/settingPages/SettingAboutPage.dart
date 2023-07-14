import 'package:boss/providers/LanguageProvider.dart';
import 'package:boss/providers/ThemeProvider.dart';
import 'package:boss/resources/AppData.dart';
import 'package:boss/resources/AppDimensions.dart';
import 'package:boss/widgets/components/MyListTileGeneralWidget.dart';
import 'package:boss/widgets/components/MyLogoTextWidget.dart';
import 'package:boss/widgets/components/MyLogoWidget.dart';
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
                style: TextStyle(
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
            MyLogoWidget(size: 60),
            MyLogoTextWidget(size: 20),
            Container(
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
              decoration: BoxDecoration(
                  color: watchTheme.colors.primary,
                  borderRadius:
                      BorderRadius.circular(AppDimensions.spacingSmall)),
            ),
          ],
        ),
      ),
    );
  }
}
