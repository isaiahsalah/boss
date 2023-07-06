import 'package:boss/providers/LanguageProvider.dart';
import 'package:boss/providers/ThemeProvider.dart';
import 'package:boss/resources/AppResources.dart';
import 'package:boss/widgets/main/MyListTile.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider watchTheme = context.watch<ThemeProvider>();
    LanguageProvider watchLanguage = context.watch<LanguageProvider>();

    ThemeProvider readTheme = context.read<ThemeProvider>();
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(AppDimensions.spacingMedium),
        children: watchLanguage.languageTexts!.pages.settings.items
            .mapIndexed(
              (i, item) => Column(
                children: [
                  MyListTile(
                    title: item.title,
                    subTitle: item.subTitle,
                    leading: AppData.myListMenuGeneral[i]["leading"],
                    trailing: Icon(Icons.arrow_forward_ios_rounded),
                    onPressed: () {
                      Navigator.pushNamed(
                          context, AppData.myListMenuGeneral[i]["onPressed"]);
                    },
                  ),
                  SizedBox(
                    height: 12,
                  )
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
