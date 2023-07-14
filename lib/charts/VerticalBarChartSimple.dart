// ignore_for_file: file_names

import 'package:boss/models/ChartModel.dart';
import 'package:boss/widgets/charts/VerticalBarChartWidgetSimple.dart';
import 'package:flutter/material.dart';

class VerticalBarChartSimple extends StatelessWidget {
  const VerticalBarChartSimple({super.key});

  @override
  Widget build(BuildContext context) {
    return VerticalBarChartWidgetSimple(
      title: "title",
      description: "description",
      barListTitle: "barListTitle",
      barListAltTitle: "barListAltTitleAlt",
      barList: <ChartDataModel>[
        ChartDataModel(title: "title", value: 444, date: DateTime(2023, 1, 2)),
        ChartDataModel(title: "title", value: 256, date: DateTime(2023, 2, 2)),
        ChartDataModel(title: "title", value: 1450, date: DateTime(2023, 3, 2)),
        ChartDataModel(title: "title", value: 1500, date: DateTime(2023, 4, 2)),
        ChartDataModel(title: "title", value: 500, date: DateTime(2023, 5, 2)),
        ChartDataModel(title: "title", value: 600, date: DateTime(2023, 6, 2)),
        ChartDataModel(title: "title", value: 600, date: DateTime(2023, 7, 2)),
        ChartDataModel(title: "title", value: 1450, date: DateTime(2023, 8, 2)),
        ChartDataModel(title: "title", value: 1500, date: DateTime(2023, 9, 2)),
        ChartDataModel(title: "title", value: 500, date: DateTime(2023, 10, 2)),
        ChartDataModel(title: "title", value: 600, date: DateTime(2023, 11, 2)),
        ChartDataModel(title: "title", value: 600, date: DateTime(2023, 12, 2)),
      ],
      barListAlt: <ChartDataModel>[
        ChartDataModel(title: "title", value: 125, date: DateTime(2022, 1, 2)),
        ChartDataModel(title: "title", value: 123, date: DateTime(2022, 2, 2)),
        ChartDataModel(title: "title", value: 5000, date: DateTime(2022, 3, 2)),
        ChartDataModel(title: "title", value: 1504, date: DateTime(2022, 4, 2)),
        ChartDataModel(title: "title", value: 850, date: DateTime(2022, 5, 2)),
        ChartDataModel(title: "title", value: 768, date: DateTime(2022, 6, 2)),
        ChartDataModel(title: "title", value: 768, date: DateTime(2022, 7, 2)),
        ChartDataModel(title: "title", value: 5000, date: DateTime(2022, 8, 2)),
        ChartDataModel(title: "title", value: 1504, date: DateTime(2022, 9, 2)),
        ChartDataModel(title: "title", value: 850, date: DateTime(2022, 10, 2)),
        ChartDataModel(title: "title", value: 768, date: DateTime(2022, 11, 2)),
        ChartDataModel(title: "title", value: 768, date: DateTime(2022, 12, 2)),
      ],
    );
  }
}
