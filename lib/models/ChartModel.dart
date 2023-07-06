// To parse this JSON data, do
//
//     final chartDataModel = chartDataModelFromJson(jsonString);

import 'dart:convert';

List<ChartDataModel> chartDataModelFromJson(String str) =>
    List<ChartDataModel>.from(
        json.decode(str).map((x) => ChartDataModel.fromJson(x)));

String chartDataModelToJson(List<ChartDataModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChartDataModel {
  final String title;
  final DateTime date;
  final double value;

  ChartDataModel({
    required this.title,
    required this.date,
    required this.value,
  });

  factory ChartDataModel.fromJson(Map<String, dynamic> json) => ChartDataModel(
        title: json["title"],
        date: DateTime.parse(json["date"]),
        value: json["value"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "date": date.toIso8601String(),
        "value": value,
      };
}
