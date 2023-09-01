// ignore_for_file: file_names

import 'dart:convert';

ListDataModel listDataModelFromJson(String str) =>
    ListDataModel.fromJson(json.decode(str));

String listDataModelToJson(ListDataModel data) => json.encode(data.toJson());

class ListDataModel {
  final String title;
  final List<ListDataModelValue> values;

  ListDataModel({
    required this.title,
    required this.values,
  });

  factory ListDataModel.fromJson(Map<String, dynamic> json) => ListDataModel(
        title: json["title"],
        values: List<ListDataModelValue>.from(
            json["values"].map((x) => ListDataModelValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "values": List<dynamic>.from(values.map((x) => x.toJson())),
      };
}

class ListDataModelValue {
  final String title;
  final List<ValueValue> values;

  ListDataModelValue({
    required this.title,
    required this.values,
  });

  factory ListDataModelValue.fromJson(Map<String, dynamic> json) =>
      ListDataModelValue(
        title: json["title"],
        values: List<ValueValue>.from(
            json["values"].map((x) => ValueValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "values": List<dynamic>.from(values.map((x) => x.toJson())),
      };
}

class ValueValue {
  final String title;
  final DateTime date;
  final int value;

  ValueValue({
    required this.title,
    required this.date,
    required this.value,
  });

  factory ValueValue.fromJson(Map<String, dynamic> json) => ValueValue(
        title: json["title"],
        date: DateTime.parse(json["date"]),
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "value": value,
      };
}
