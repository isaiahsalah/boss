// ignore_for_file: file_names

import 'package:boss/constants/widget_const.dart';
import 'package:boss/widgets/components/logoSingleton_widget.dart';
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
    //WidgetProvider watchWidgetShow = context.watch<WidgetProvider>();
    List<Widget> widgetList = [
      const SizedBox(
        height: 20,
      )
    ];
/*
    widgetList.addAll(watchWidgetShow.listWidgets
        .where((itemWidget) => itemWidget.estado == true)
        .map((itemWidget) => WidgetConstants.listWidgets[itemWidget.params])
        .toList());*/
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(children: widgetList));
  }
}
