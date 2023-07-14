import 'package:boss/providers/LanguageProvider.dart';
import 'package:boss/providers/ThemeProvider.dart';
import 'package:boss/resources/AppDimensions.dart';
import 'package:boss/widgets/components/MyComboBoxWidget.dart';
import 'package:boss/widgets/components/MyListTileGeneralWidget.dart';
import 'package:boss/widgets/components/MySwithWidget.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GeneralPage extends StatefulWidget {
  const GeneralPage({super.key});

  @override
  State<GeneralPage> createState() => _GeneralPageState();
}

class _GeneralPageState extends State<GeneralPage> {
  bool _lights = false;
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    LanguageProvider watchLanguage = context.watch<LanguageProvider>();
    LanguageProvider readLanguage = context.read<LanguageProvider>();
    ThemeProvider watchTheme = context.watch<ThemeProvider>();
    ThemeProvider readTheme = context.read<ThemeProvider>();

    List<dynamic> myListMenuSettingGeneral = [
      MySwitchWidget(
        value: _lights,
        onChanged: (bool value) {
          setState(() {
            _lights = value;
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
      )
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
                style: TextStyle(
                  fontSize: AppDimensions.fontSizeSmall,
                )),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingMedium),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.spacingMedium),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: watchLanguage
                  .languageTexts!.pages.settings.pages.general.options
                  .mapIndexed(
                    (i, item) => MyListTileGeneralWidget(
                        title: item.title,
                        subtitle: item.subTitle.toString(),
                        trailing: myListMenuSettingGeneral[i]),
                  )
                  .toList(),
            ),
          ),
          decoration: BoxDecoration(
              color: watchTheme.colors.primary,
              borderRadius: BorderRadius.circular(AppDimensions.spacingSmall)),
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
