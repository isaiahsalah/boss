// ignore_for_file: file_names

import 'package:boss/providers/WidgetShowProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BoardPage extends StatefulWidget {
  const BoardPage({super.key});

  @override
  State<BoardPage> createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  List<Color> gradientColors = [
    Colors.red,
    Colors.blue,
  ];
  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    WidgetShowProvider watchWidgetShow = context.watch<WidgetShowProvider>();
    List<Widget> widgetList = [
      const SizedBox(
        height: 20,
      )
    ];

    widgetList.addAll(watchWidgetShow.listWidgets
        .where((itemWidget) => itemWidget.state == true)
        .map((itemWidget) => itemWidget.widget)
        .toList());
    return Scaffold(body: ListView(children: widgetList));
  }
}
