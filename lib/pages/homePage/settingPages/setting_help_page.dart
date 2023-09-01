// ignore_for_file: file_names

import 'package:boss/providers/language_provider.dart';
import 'package:boss/providers/theme_provider.dart';
import 'package:boss/resources/dimensions_resource.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}
/*
List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      headerValue: 'Panel $index',
      expandedValue: 'This is item number $index',
    );
  });
}*/

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  late List<Item> _data;

  @override
  void initState() {
    super.initState();
    _data = Provider.of<LanguageProvider>(context, listen: false)
        .languageTexts!
        .pages
        .settings
        .pages
        .help
        .options
        .map((item) => Item(
              headerValue: item.title,
              expandedValue: item.subTitle,
            ))
        .toList();
  }
  /*final List<Item> data = <Item>[
    Item(
      headerValue: "",
      expandedValue: "",
    )
  ];*/

  @override
  Widget build(BuildContext context) {
    LanguageProvider watchLanguage = context.watch<LanguageProvider>();
    ThemeProvider watchTheme = context.watch<ThemeProvider>();

    /*final List<Item> data =
        watchLanguage.languageTexts!.pages.settings.pages.help.options
            .map((item) => Item(
                  headerValue: item.title,
                  expandedValue: item.subTitle,
                ))
            .toList();*/

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                watchLanguage.languageTexts!.pages.settings.pages.help.subTitle,
                style: TextStyle(
                  fontSize: AppDimensions.fontSizeXXSmall,
                  color: watchTheme.colors.lightPrimary,
                )),
            Text(watchLanguage.languageTexts!.pages.settings.pages.help.title,
                style: const TextStyle(
                  fontSize: AppDimensions.fontSizeSmall,
                )),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spacingMedium),
          child: Container(
            decoration: BoxDecoration(
                color: watchTheme.colors.background,
                borderRadius:
                    BorderRadius.circular(AppDimensions.spacingSmall)),
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.spacingMedium),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [_buildPanel(watchTheme)],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPanel(ThemeProvider watchTheme) {
    return ExpansionPanelList(
      elevation: 0,
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          backgroundColor: watchTheme.colors.background,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              tileColor: watchTheme.colors.background,
              title: Text(item.headerValue),
            );
          },
          body: ListTile(
            tileColor: watchTheme.colors.background,
            title: Text(
              item.expandedValue,
              style: TextStyle(
                  fontSize: AppDimensions.fontSizeXSmall,
                  color: watchTheme.colors.lightPrimary),
            ),
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}
