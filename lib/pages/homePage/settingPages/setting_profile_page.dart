// ignore_for_file: file_names

import 'package:boss/providers/language_provider.dart';
import 'package:boss/providers/theme_provider.dart';
import 'package:boss/providers/user_provider.dart';
import 'package:boss/resources/dimensions_resource.dart';
import 'package:boss/widgets/components/listTileGeneral_widget.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

const List<String> list = <String>['Semana', 'Mes', 'Año'];

class _ProfilePageState extends State<ProfilePage> {
  String dropdownValue = list.first;

  final List<dynamic> myListMenuSettingProfile = [
    IconButton(
        onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios_rounded)),
  ];
  @override
  Widget build(BuildContext context) {
    LanguageProvider watchLanguage = context.watch<LanguageProvider>();
    UserProvider watchUser = context.watch<UserProvider>();

    ThemeProvider watchTheme = context.watch<ThemeProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                watchLanguage
                    .languageTexts!.pages.settings.pages.profile.subTitle,
                style: TextStyle(
                  fontSize: AppDimensions.fontSizeXXSmall,
                  color: watchTheme.colors.lightPrimary,
                )),
            Text(
                watchLanguage.languageTexts!.pages.settings.pages.profile.title,
                style: const TextStyle(
                  fontSize: AppDimensions.fontSizeSmall,
                )),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingMedium),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppDimensions.spacingMedium),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        watchUser.user?.nombre ?? "ola",
                        style: const TextStyle(
                            fontSize: AppDimensions.fontSizeSmall),
                      ),
                    ],
                  ),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.edit))
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: watchTheme.colors.background,
                  borderRadius:
                      BorderRadius.circular(AppDimensions.spacingSmall)),
              child: Padding(
                padding: const EdgeInsets.all(AppDimensions.spacingMedium),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: watchLanguage
                      .languageTexts!.pages.settings.pages.profile.options
                      .mapIndexed(
                        (i, item) => MyListTileGeneralWidget(
                          title: item.title,
                          subtitle: item.subTitle,
                          trailing: myListMenuSettingProfile[i],
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
