import 'package:boss/models/ChartModel.dart';
import 'package:boss/widgets/charts/MyLineChartAltWidget.dart';
import 'package:flutter/material.dart';

class ExampleLineChartAlt extends StatelessWidget {
  const ExampleLineChartAlt({super.key});

  @override
  Widget build(BuildContext context) {
    return MyLineChartAltWidget(
      title: "Titulito",
      description: "bal bla",
      lineListTitle: "Item",
      lineListAltTitle: "ItemAlt",
      lineList: [
        ChartDataModel(title: "title", date: DateTime(2022, 1, 2), value: 0),
        ChartDataModel(title: "title", date: DateTime(2022, 1, 3), value: 0),
        ChartDataModel(title: "title", date: DateTime(2022, 1, 4), value: 700),
        ChartDataModel(title: "title", date: DateTime(2022, 1, 5), value: 200),
        ChartDataModel(title: "title", date: DateTime(2022, 1, 6), value: 10),
        ChartDataModel(title: "title", date: DateTime(2022, 1, 7), value: 500),
      ],
      lineListAlt: [
        ChartDataModel(title: "title", date: DateTime(2022, 1, 2), value: 500),
        ChartDataModel(title: "title", date: DateTime(2022, 1, 3), value: 400),
        ChartDataModel(title: "title", date: DateTime(2022, 1, 4), value: 300),
        ChartDataModel(title: "title", date: DateTime(2022, 1, 6), value: 200),
        ChartDataModel(title: "title", date: DateTime(2022, 1, 7), value: 50),
        ChartDataModel(title: "title", date: DateTime(2022, 1, 8), value: 550),
      ],
    );
  }
}
