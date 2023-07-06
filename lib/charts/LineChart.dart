import 'package:boss/models/ChartModel.dart';
import 'package:boss/widgets/charts/MyLineChartWidget.dart';
import 'package:flutter/material.dart';

class ExampleLineChart extends StatelessWidget {
  const ExampleLineChart({super.key});

  @override
  Widget build(BuildContext context) {
    return MyLineChartWidget(
      title: "Titulito",
      description: "bal bla",
      lineListTitle: "Item",
      lineListAltTitle: "ItemAlt",
      lineList: [
        ChartDataModel(title: "title", date: DateTime(2022, 1, 2), value: 444),
        ChartDataModel(title: "title", date: DateTime(2022, 1, 3), value: 256),
        ChartDataModel(title: "title", date: DateTime(2022, 1, 4), value: 1450),
        ChartDataModel(title: "title", date: DateTime(2022, 1, 5), value: 1500),
        ChartDataModel(title: "title", date: DateTime(2022, 1, 6), value: 500),
        ChartDataModel(title: "title", date: DateTime(2022, 1, 7), value: 600),
      ],
      lineListAlt: [
        ChartDataModel(title: "title", date: DateTime(2022, 1, 2), value: 500),
        ChartDataModel(title: "title", date: DateTime(2022, 1, 3), value: 256),
        ChartDataModel(title: "title", date: DateTime(2022, 1, 4), value: 2000),
        ChartDataModel(title: "title", date: DateTime(2022, 1, 6), value: 150),
        ChartDataModel(title: "title", date: DateTime(2022, 1, 7), value: 900),
        ChartDataModel(title: "title", date: DateTime(2022, 1, 8), value: 900),
      ],
    );
  }
}
