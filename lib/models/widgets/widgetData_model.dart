// ignore_for_file: file_names
// To parse this JSON data, do
//
//     final widgetDataModel = widgetDataModelFromJson(jsonString);

import 'dart:convert';

WidgetDataModel widgetDataModelFromJson(String str) =>
    WidgetDataModel.fromJson(json.decode(str));

String widgetDataModelToJson(WidgetDataModel data) =>
    json.encode(data.toJson());

class WidgetDataModel {
  final String titulo;
  final String descripcion;
  late final List<WidgetContentDataModel> contenido;

  WidgetDataModel({
    required this.titulo,
    required this.descripcion,
    required this.contenido,
  });

  factory WidgetDataModel.fromJson(Map<String, dynamic> json) =>
      WidgetDataModel(
        titulo: json["Titulo"],
        descripcion: json["Descripcion"],
        contenido: List<WidgetContentDataModel>.from(
            json["Contenido"].map((x) => WidgetContentDataModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Titulo": titulo,
        "Descripcion": descripcion,
        "Contenido": List<dynamic>.from(contenido.map((x) => x.toJson())),
      };
}

class WidgetContentDataModel {
  final String titulo;
  final String descripcion;
  final List<WidgetContentContentDataModel> contenido;
  bool estado = true;

  WidgetContentDataModel({
    required this.titulo,
    required this.descripcion,
    required this.contenido,
  });

  factory WidgetContentDataModel.fromJson(Map<String, dynamic> json) =>
      WidgetContentDataModel(
        titulo: json["Titulo"],
        descripcion: json["Descripcion"],
        contenido: List<WidgetContentContentDataModel>.from(json["Contenido"]
            .map((x) => WidgetContentContentDataModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Titulo": titulo,
        "Descripcion": descripcion,
        "Contenido": List<dynamic>.from(contenido.map((x) => x.toJson())),
      };
}

class WidgetContentContentDataModel {
  final String? nombre;
  final double total;
  final String? posicion;
  final String? descripcion;

  WidgetContentContentDataModel({
    this.nombre,
    required this.total,
    this.posicion,
    this.descripcion,
  });

  factory WidgetContentContentDataModel.fromJson(Map<String, dynamic> json) =>
      WidgetContentContentDataModel(
        nombre: json["Nombre"],
        total: json["Total"]?.toDouble(),
        posicion: json["Posicion"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "Nombre": nombre,
        "Total": total,
        "Posicion": posicion,
        "Descripcion": descripcion,
      };
}

/*
import 'dart:convert';

ChartModel chartDataModelFromJson(String str) =>
    ChartModel.fromJson(json.decode(str));

String chartDataModelToJson(ChartModel data) => json.encode(data.toJson());

class ChartModel {
  final int id;
  final String name;
  final String description;
  final List<ChartContentModel>? content;

  ChartModel({
    this.id = 0,
    this.name = "",
    this.description = "",
    this.content,
  });

  factory ChartModel.fromJson(Map<String, dynamic> json) => ChartModel(
        id: json["Id"] ?? 0,
        name: json["Name"],
        description: json["Description"] ?? "",
        content: List<ChartContentModel>.from(
            json["Content"].map((x) => ChartContentModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "Description": description,
        "Content": List<dynamic>.from(content!.map((x) => x.toJson())),
      };
}

class ChartContentModel {
  final int id;
  final String name;
  final String description;
  final List<ChartValueModel>? content;

  ChartContentModel({
    this.id = 0,
    this.name = "",
    this.description = "",
    this.content,
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
        "Content": List<dynamic>.from(content!.map((x) => x.toJson())),
      };
}

class ChartValueModel {
  final int id;
  final String name;
  final DateTime? datetime;
  final double value;

  ChartValueModel({
    this.id = 0,
    this.name = "",
    this.datetime,
    this.value = 0,
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
        "DateTime": datetime!.toIso8601String(),
        "Value": value,
      };
}*/
