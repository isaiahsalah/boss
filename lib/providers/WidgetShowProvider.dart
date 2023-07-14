// ignore_for_file: file_names

import 'package:boss/charts/BalanceChart.dart';
import 'package:boss/charts/TableChart.dart';
import 'package:boss/charts/HorizontalBarChart.dart';
import 'package:boss/charts/LineChart.dart';
import 'package:boss/charts/LineChartAlt.dart';
import 'package:boss/charts/MonthVerticalBarChart.dart';
import 'package:boss/charts/MultiPieChart.dart';
import 'package:boss/charts/PieChart.dart';
import 'package:boss/charts/ResumeBoxesChart.dart';
import 'package:boss/charts/VerticalBarChart.dart';
import 'package:boss/charts/VerticalBarChartSimple.dart';
import 'package:flutter/material.dart';

class ItemWidget {
  int id;
  Widget widget;
  bool state;

  ItemWidget({
    required this.id,
    required this.widget,
    required this.state,
  });
}

class WidgetShowProvider with ChangeNotifier {
  List<ItemWidget> _listWidgets = <ItemWidget>[
    ItemWidget(
      id: 1,
      widget: ExampleBalanceChart(),
      state: true,
    ),
    ItemWidget(
      id: 2,
      widget: ResumeBoxesChart(),
      state: true,
    ),
    ItemWidget(
      id: 3,
      widget: TableChart(),
      state: true,
    ),
    ItemWidget(
      id: 4,
      widget: ExampleLineChart(),
      state: true,
    ),
    /*ItemWidget(
      id: 5,
      widget: VerticalBarChartSimple(),
      state: true,
    ),
    ItemWidget(
      id: 6,
      widget: ExampleHorizontalBarChart(),
      state: true,
    ),
    ItemWidget(
      id: 7,
      widget: ExampleLineChartAlt(),
      state: true,
    ),
    ItemWidget(
      id: 8,
      widget: ExampleMultiPieChart(),
      state: true,
    ),
    ItemWidget(
      id: 9,
      widget: ExampleMonthVerticalBarChart(),
      state: true,
    ),
    ItemWidget(
      id: 10,
      widget: ExamplePieChart(),
      state: true,
    ),
    ItemWidget(
      id: 11,
      widget: ExampleVerticalBarChart(),
      state: true,
    ),*/
  ];

  List<ItemWidget> get listWidgets => _listWidgets;

  Future<void> listWidgetsChange(List<ItemWidget> listWidgets) async {
    _listWidgets = listWidgets;
    notifyListeners();
  }
}
