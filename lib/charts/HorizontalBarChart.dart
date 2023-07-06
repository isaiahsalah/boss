import 'package:boss/models/ChartModel.dart';
import 'package:boss/widgets/charts/MyHorizontalBarChart.dart';
import 'package:flutter/material.dart';

class ExampleHorizontalBarChart extends StatelessWidget {
  const ExampleHorizontalBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return MyHorizontalBarChartWidget(
      title: "",
      description: "",
      chartListTitle: "",
      chartListAltTitle: "",
      chartList: [
        ChartDataModel(title: "title", date: DateTime(2022, 1, 2), value: 444),
        ChartDataModel(title: "title", date: DateTime(2022, 1, 3), value: 256),
        ChartDataModel(title: "title", date: DateTime(2022, 1, 4), value: 1450),
        ChartDataModel(title: "title", date: DateTime(2022, 1, 5), value: 1500),
        ChartDataModel(title: "title", date: DateTime(2022, 1, 6), value: 500),
        ChartDataModel(title: "title", date: DateTime(2022, 1, 7), value: 600),
      ],
      chartListAlt: [
        ChartDataModel(title: "title", date: DateTime(2022, 1, 2), value: 444),
        ChartDataModel(title: "title", date: DateTime(2022, 1, 3), value: 256),
        ChartDataModel(title: "title", date: DateTime(2022, 1, 4), value: 1450),
        ChartDataModel(title: "title", date: DateTime(2022, 1, 5), value: 1500),
        ChartDataModel(title: "title", date: DateTime(2022, 1, 6), value: 500),
        ChartDataModel(title: "title", date: DateTime(2022, 1, 7), value: 600),
      ],
    );
  }
}
