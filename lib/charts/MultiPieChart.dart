// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:boss/models/ChartModel.dart';
import 'package:boss/widgets/charts/MyMultiPieChartWidget.dart';

class ExampleMultiPieChart extends StatelessWidget {
  const ExampleMultiPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return MyMultiPieChartWidget(
      title: "title",
      description: "description",
      pieList: <ChartDataModel>[
        ChartDataModel(title: "title", value: 444, date: DateTime.now()),
        ChartDataModel(title: "title", value: 256, date: DateTime.now()),
        ChartDataModel(title: "title", value: 1450, date: DateTime.now()),
        ChartDataModel(title: "title", value: 1500, date: DateTime.now()),
      ],
      pieListAlt: <ChartDataModel>[
        ChartDataModel(title: "title", value: 550, date: DateTime.now()),
        ChartDataModel(title: "title", value: 456, date: DateTime.now()),
        ChartDataModel(title: "title", value: 356, date: DateTime.now()),
        ChartDataModel(title: "title", value: 500, date: DateTime.now()),
      ],
    );
  }
}
