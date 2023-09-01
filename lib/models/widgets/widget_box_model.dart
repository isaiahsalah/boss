// To parse this JSON data, do
//
//     final widgetBoxModel = widgetBoxModelFromJson(jsonString);

import 'dart:convert';

WidgetBoxModel widgetBoxModelFromJson(String str) =>
    WidgetBoxModel.fromJson(json.decode(str));

String widgetBoxModelToJson(WidgetBoxModel data) => json.encode(data.toJson());

class WidgetBoxModel {
  final String titulo;
  final String descripcion;
  final double ingresos;
  final double egresos;

  WidgetBoxModel({
    required this.titulo,
    required this.descripcion,
    required this.ingresos,
    required this.egresos,
  });

  factory WidgetBoxModel.fromJson(Map<String, dynamic> json) => WidgetBoxModel(
        titulo: json["Titulo"],
        descripcion: json["Descripcion"],
        ingresos: json["Ingresos"]?.toDouble(),
        egresos: json["Egresos"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "Titulo": titulo,
        "Descripcion": descripcion,
        "Ingresos": ingresos,
        "Egresos": egresos,
      };
}
