import 'package:boss/providers/LanguageProvider.dart';
import 'package:boss/resources/AppResources.dart';
import 'package:boss/widgets/main/MyListTile.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    LanguageProvider watchLanguage = context.watch<LanguageProvider>();

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(AppDimensions.spacingMedium),
        children: watchLanguage.languageTexts!.pages.stats.items
            .mapIndexed(
              (i, item) => Column(
                children: [
                  MyListTile(
                    title: item.title,
                    subTitle: item.subTitle,
                    leading: AppData.myListMenuStats[i]["leading"],
                    trailing: Icon(Icons.arrow_forward_ios_rounded),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppData.myListMenuStats[i]["onPressed"],
                      );
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
