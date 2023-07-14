// ignore_for_file: file_names

import 'package:boss/models/ChartModel.dart';
import 'package:boss/widgets/charts/MyVerticalBarChartWidget.dart';
import 'package:flutter/material.dart';

class ExampleVerticalBarChart extends StatelessWidget {
  const ExampleVerticalBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return MyVerticalBarChartWidget(
      title: "title",
      description: "description",
      barListTitle: "barListTitle",
      barListAltTitle: "barListAltTitleAlt",
      barList: <ChartDataModel>[
        ChartDataModel(title: "title", value: 444, date: DateTime.now()),
        ChartDataModel(title: "title", value: 256, date: DateTime.now()),
        ChartDataModel(title: "title", value: 1450, date: DateTime.now()),
        ChartDataModel(title: "title", value: 1500, date: DateTime.now()),
        ChartDataModel(title: "title", value: 500, date: DateTime.now()),
        ChartDataModel(title: "title", value: 600, date: DateTime.now()),
        ChartDataModel(title: "title", value: 600, date: DateTime.now()),
      ],
      barListAlt: <ChartDataModel>[
        ChartDataModel(title: "title", value: 125, date: DateTime.now()),
        ChartDataModel(title: "title", value: 123, date: DateTime.now()),
        ChartDataModel(title: "title", value: 5000, date: DateTime.now()),
        ChartDataModel(title: "title", value: 1504, date: DateTime.now()),
        ChartDataModel(title: "title", value: 850, date: DateTime.now()),
        ChartDataModel(title: "title", value: 768, date: DateTime.now()),
        ChartDataModel(title: "title", value: 768, date: DateTime.now()),
      ],
    );
  }
}
