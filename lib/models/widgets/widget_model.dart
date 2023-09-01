// To parse this JSON data, do
//
//     final widgetModel = widgetModelFromJson(jsonString);

import 'dart:convert';

List<WidgetModel> widgetModelFromJson(String str) => List<WidgetModel>.from(
    json.decode(str).map((x) => WidgetModel.fromJson(x)));

String widgetModelToJson(List<WidgetModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WidgetModel {
  final int id;
  final String nombre;
  final String descripcion;
  final String params;
  bool estado;

  WidgetModel({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.params,
    this.estado = true,
  });

  factory WidgetModel.fromJson(Map<String, dynamic> json) => WidgetModel(
        id: json["Id"],
        nombre: json["Nombre"],
        descripcion: json["Descripcion"],
        params: json["Params"],
        estado: json["Estado"] ?? true,
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Nombre": nombre,
        "Descripcion": descripcion,
        "Params": params,
        "Estado": estado,
      };
}
