// ignore_for_file: file_names

import 'package:boss/providers/language_provider.dart';
import 'package:boss/providers/theme_provider.dart';
import 'package:boss/resources/dimensions_resource.dart';
import 'package:boss/resources/resources.dart';
import 'package:boss/widgets/components/comboBox_widget.dart';
import 'package:boss/widgets/components/listTileGeneral_widget.dart';
import 'package:boss/widgets/components/swith_widget.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GeneralPage extends StatefulWidget {
  const GeneralPage({super.key});

  @override
  State<GeneralPage> createState() => _GeneralPageState();
}

class _GeneralPageState extends State<GeneralPage> {
  //final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  //late Future<String> _language;

  bool _lights = false;
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    LanguageProvider watchLanguage = context.watch<LanguageProvider>();
    LanguageProvider readLanguage = context.read<LanguageProvider>();
    ThemeProvider watchTheme = context.watch<ThemeProvider>();
    ThemeProvider readTheme = context.read<ThemeProvider>();

    List<dynamic> myListMenuSettingGeneral = [
      {
        "title": "Configuraciones",
        "subtitle": "Configura las  variables de Boss",
        "trailing": MySwitchWidget(
          value: _lights,
          onChanged: (bool value) {
            setState(() {
              _lights = value;
            });
          },
        ),
      },
      {
        "title": "Configuraciones",
        "subtitle": "Configura las  variables de Boss",
        "trailing": MyComboBoxWidget(
          listData: list,
          dropdownValue: dropdownValue,
          onChange: (String? value) {
            setState(() {
              dropdownValue = value!;
            });
          },
        ),
      },
      {
        "title": "Tema Oscuro",
        "subtitle": "Configura las  variables de Boss",
        "trailing": MySwitchWidget(
          value: watchTheme.isDarkTheme,
          onChanged: (bool value) {
            setState(() {
              readTheme.updateColors();
            });
          },
        ),
      },

      /*
      MyComboBoxWidget(
        listData: list,
        dropdownValue: dropdownValue,
        onChange: (String? value) {
          setState(() {
            dropdownValue = value!;
          });
        },
      ),
      MyComboBoxWidget(
        listData: list,
        dropdownValue: dropdownValue,
        onChange: (String? value) {
          setState(() {
            dropdownValue = value!;
          });
        },
      ),
      MyComboBoxWidget(
        listData: watchLanguage.listLanguage,
        dropdownValue: watchLanguage.dropdownValue,
        onChange: (String? value) {
          readLanguage.languageChange(lang: value!);

          /*setState(() {
                        dropdownValue = value!;
                      });*/
        },
      ),
      MySwitchWidget(
        value: watchTheme.isDarkTheme,
        onChanged: (bool value) {
          setState(() {
            readTheme.updateColors();
          });
        },
      )*/
    ];

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                watchLanguage
                    .languageTexts!.pages.settings.pages.general.subTitle,
                style: TextStyle(
                  fontSize: AppDimensions.fontSizeXXSmall,
                  color: watchTheme.colors.lightPrimary,
                )),
            Text(
                watchLanguage.languageTexts!.pages.settings.pages.general.title,
                style: const TextStyle(
                  fontSize: AppDimensions.fontSizeSmall,
                )),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingMedium),
        child: Container(
          decoration: BoxDecoration(
              color: watchTheme.colors.background,
              borderRadius: BorderRadius.circular(AppDimensions.spacingSmall)),
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.spacingMedium),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: myListMenuSettingGeneral
                  .mapIndexed(
                    (i, item) => MyListTileGeneralWidget(
                      title: item['title'],
                      subtitle: item['subtitle'],
                      trailing: item['trailing'],
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}

const List<String> list = <String>['Semana', 'Mes', 'Año'];

List<String> listLanguage3(dynamic listaDeMapas) {
  List<String> nombres = [];
  for (var mapa in listaDeMapas) {
    String nombre = mapa['nombre'];
    nombres.add(nombre);
  }
  return nombres;
}
