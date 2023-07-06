import 'package:boss/charts/BalanceChart.dart';
import 'package:boss/charts/HorizontalBarChart.dart';
import 'package:boss/charts/LineChart.dart';
import 'package:boss/charts/MonthVerticalBarChart.dart';
import 'package:boss/charts/PieChart.dart';
import 'package:boss/charts/VerticalBarChart.dart';
import 'package:flutter/material.dart';

class ItemWidget {
  String id;
  String title;
  String subtitle;
  Widget widget;
  bool state;

  ItemWidget({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.widget,
    required this.state,
  });
}

class WidgetShowProvider with ChangeNotifier {
  List<ItemWidget> _listWidgets = <ItemWidget>[
    ItemWidget(
      id: '1',
      title: 'Saldo',
      subtitle: 'Description del widget',
      widget: ExampleBalanceChart(),
      state: true,
    ),
    ItemWidget(
      id: '2',
      title: 'widget1',
      subtitle: 'Description del widget',
      widget: ExamplePieChart(),
      state: true,
    ),
    ItemWidget(
      id: '2',
      title: 'widget2',
      subtitle: 'Description del widget',
      widget: ExampleVerticalBarChart(),
      state: true,
    ),
    ItemWidget(
      id: '2',
      title: 'widget2',
      subtitle: 'Description del widget',
      widget: ExampleMonthVerticalBarChart(),
      state: true,
    ),
    ItemWidget(
      id: '2',
      title: 'widget2',
      subtitle: 'Description del widget',
      widget: ExampleLineChart(),
      state: true,
    ),
    ItemWidget(
      id: '2',
      title: 'widget2',
      subtitle: 'Description del widget',
      widget: ExampleHorizontalBarChart(),
      state: true,
    ),
  ];

  List<ItemWidget> get listWidgets => _listWidgets;

  Future<void> listWidgetsChange(List<ItemWidget> listWidgets) async {
    _listWidgets = listWidgets;
    notifyListeners();
  }
}
