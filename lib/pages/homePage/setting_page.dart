// ignore_for_file: file_names

import 'package:boss/providers/language_provider.dart';
import 'package:boss/resources/resources.dart';
import 'package:boss/widgets/main/listTile_widget.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    LanguageProvider watchLanguage = context.watch<LanguageProvider>();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView(
        padding: const EdgeInsets.all(AppDimensions.spacingMedium),
        children: AppData.myListMenuSetting
            .mapIndexed(
              (i, item) => Column(
                children: [
                  MyListTile(
                    title: item["title"],
                    subTitle: item["subTitle"],
                    leading: item["leading"],
                    trailing: const Icon(Icons.arrow_forward_ios_rounded),
                    onPressed: () {
                      AppData.myListMenuSetting[i]["onPressed"](context);
                    },
                  ),
                  const SizedBox(
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
