import 'package:boss/models/ChartModel.dart';
import 'package:boss/widgets/charts/MyPieChartWidget.dart';
import 'package:flutter/material.dart';

class ExamplePieChart extends StatelessWidget {
  const ExamplePieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return MyPieChartWidget(
      title: "title",
      description: "description",
      pieList: <ChartDataModel>[
        ChartDataModel(title: "title", value: 444, date: DateTime.now()),
        ChartDataModel(title: "title", value: 256, date: DateTime.now()),
        ChartDataModel(title: "title", value: 1450, date: DateTime.now()),
        ChartDataModel(title: "title", value: 1500, date: DateTime.now()),
        ChartDataModel(title: "title", value: 500, date: DateTime.now()),
        ChartDataModel(title: "title", value: 600, date: DateTime.now()),
      ],
      pieListAlt: <ChartDataModel>[
        ChartDataModel(title: "title", value: 550, date: DateTime.now()),
        ChartDataModel(title: "title", value: 456, date: DateTime.now()),
        ChartDataModel(title: "title", value: 356, date: DateTime.now()),
        ChartDataModel(title: "title", value: 500, date: DateTime.now()),
        ChartDataModel(title: "title", value: 800, date: DateTime.now()),
        ChartDataModel(title: "title", value: 500, date: DateTime.now()),
        ChartDataModel(title: "title", value: 500, date: DateTime.now()),
      ],
    );
  }
}
