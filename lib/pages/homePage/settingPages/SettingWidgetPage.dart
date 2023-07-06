import 'package:boss/providers/ThemeProvider.dart';
import 'package:boss/providers/WidgetShowProvider.dart';
import 'package:boss/resources/AppDimensions.dart';
import 'package:boss/widgets/components/MySwithWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WidgetPage extends StatelessWidget {
  const WidgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: ReorderableExample(),
      ),
    );
  }
}

class ReorderableExample extends StatefulWidget {
  const ReorderableExample({super.key});

  @override
  State<ReorderableExample> createState() => _ReorderableListViewExampleState();
}

class _ReorderableListViewExampleState extends State<ReorderableExample> {
  /*final List<String> _items = [
    "widget 1",
    "widget 2",
    "widget 3",
    "widget 4",
    "widget 5",
    "widget 6",
  ];*/

  @override
  Widget build(BuildContext context) {
    ThemeProvider watchTheme = context.watch<ThemeProvider>();
    ThemeProvider readTheme = context.read<ThemeProvider>();

    WidgetShowProvider watchWidgetShow = context.watch<WidgetShowProvider>();
    WidgetShowProvider readWidgetShow = context.read<WidgetShowProvider>();

    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

    return Padding(
      padding: const EdgeInsets.all(AppDimensions.spacingMedium),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimensions.spacingSmall),
          color: watchTheme.colors.primary,
        ),
        child: ReorderableListView(
          shrinkWrap: true,
          buildDefaultDragHandles: true,
          padding: const EdgeInsets.all(AppDimensions.spacingMedium),
          children: <Widget>[
            for (int index = 0;
                index < watchWidgetShow.listWidgets.length;
                index += 1)
              Container(
                key: Key('$index'),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: watchTheme.colors.lightBackground,
                      width: 1,
                    ),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppDimensions.spacingSmall),
                  child: ListTile(
                    trailing: MySwitchWidget(
                      value: watchWidgetShow.listWidgets[index].state,
                      onChanged: (i) {
                        var listWidgets = watchWidgetShow.listWidgets;
                        listWidgets[index].state = i;
                        readWidgetShow.listWidgetsChange(listWidgets);
                      },
                    ),
                    tileColor: oddItemColor,
                    contentPadding: EdgeInsets.only(
                      bottom: 0,
                      left: 0,
                      top: 0,
                      right: AppDimensions.spacingMedium,
                    ),
                    title: Text(watchWidgetShow.listWidgets[index].title),
                    subtitle: Text(
                      watchWidgetShow.listWidgets[index].subtitle,
                      style: TextStyle(
                        color: watchTheme.colors.lightPrimary,
                      ),
                    ),
                  ),
                ),
              ),
          ],
          onReorder: (int oldIndex, int newIndex) {
            setState(() {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              var listWidgets = watchWidgetShow.listWidgets;

              final ItemWidget item = listWidgets.removeAt(oldIndex);
              listWidgets.insert(newIndex, item);
              readWidgetShow.listWidgetsChange(listWidgets);
              //final String item = _items.removeAt(oldIndex);
              //_items.insert(newIndex, item);
            });
          },
        ),
      ),
    );
  }
}
