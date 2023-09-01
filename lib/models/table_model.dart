// ignore_for_file: file_names

import 'dart:convert';

TableModel tableModelFromJson(String str) =>
    TableModel.fromJson(json.decode(str));

String tableModelToJson(TableModel data) => json.encode(data.toJson());

class TableModel {
  final int? id;
  final String? titulo;
  final String? descripcion;
  final List<Map<String, dynamic>>? contenido;

  TableModel({
    this.id = 0,
    this.titulo = "",
    this.descripcion = "",
    this.contenido,
  });

  factory TableModel.fromJson(Map<String, dynamic> json) => TableModel(
        id: json["Id"] ?? 0,
        titulo: json["Titulo"],
        descripcion: json["Descripcion"] ?? "",
        contenido:
            List<Map<String, dynamic>>.from(json["Contenido"].map((x) => (x))),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Titulo": titulo,
        "Description": descripcion,
        "Contenido": contenido,
      };
}
/*
class ChartContentModel {
  final int id;
  final String name;
  final String description;
  final List<ChartValueModel> content;

  ChartContentModel({
    required this.id,
    required this.name,
    required this.description,
    required this.content,
  });

  factory ChartContentModel.fromJson(Map<String, dynamic> json) =>
      ChartContentModel(
        id: json["Id"] ?? 0,
        name: json["Name"],
        description: json["Description"] ?? "",
        content: List<ChartValueModel>.from(
            json["Content"].map((x) => ChartValueModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "Description": description,
        "Content": List<dynamic>.from(content.map((x) => x.toJson())),
      };
}

class ChartValueModel {
  final int id;
  final String name;
  final DateTime datetime;
  final double value;

  ChartValueModel({
    required this.id,
    required this.name,
    required this.datetime,
    required this.value,
  });

  factory ChartValueModel.fromJson(Map<String, dynamic> json) =>
      ChartValueModel(
        id: json["Id"] ?? 0,
        name: json["Name"],
        datetime: DateTime.parse(json["DateTime"]),
        value: json["Value"]?.toDouble() ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "DateTime": datetime.toIso8601String(),
        "Value": value,
      };
}*/
