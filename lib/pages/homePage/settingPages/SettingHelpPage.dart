import 'package:boss/providers/LanguageProvider.dart';
import 'package:boss/providers/ThemeProvider.dart';
import 'package:boss/resources/AppDimensions.dart';
import 'package:boss/widgets/components/MyListTileGeneralWidget.dart';
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

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      headerValue: 'Panel $index',
      expandedValue: 'This is item number $index',
    );
  });
}

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  final List<Item> _data = generateItems(8);

  @override
  Widget build(BuildContext context) {
    LanguageProvider watchLanguage = context.watch<LanguageProvider>();
    LanguageProvider readLanguage = context.read<LanguageProvider>();
    ThemeProvider watchTheme = context.watch<ThemeProvider>();
    ThemeProvider readTheme = context.read<ThemeProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("subTitle",
                style: TextStyle(
                  fontSize: AppDimensions.fontSizeXXSmall,
                  color: watchTheme.colors.lightPrimary,
                )),
            Text(watchLanguage.languageTexts!.appTitle,
                style: TextStyle(
                  fontSize: AppDimensions.fontSizeSmall,
                )),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spacingMedium),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.spacingMedium),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [_buildPanel(watchTheme)],
              ),
            ),
            decoration: BoxDecoration(
                color: watchTheme.colors.primary,
                borderRadius:
                    BorderRadius.circular(AppDimensions.spacingSmall)),
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
          backgroundColor: watchTheme.colors.primary,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              tileColor: watchTheme.colors.primary,
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
