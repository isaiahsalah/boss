// To parse this JSON data, do
//
//     final moduleModel = moduleModelFromJson(jsonString);

import 'dart:convert';

List<ModuleModel> moduleModelFromJson(String str) => List<ModuleModel>.from(
    json.decode(str).map((x) => ModuleModel.fromJson(x)));

String moduleModelToJson(List<ModuleModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModuleModel {
  final String id;
  final String nombre;
  final String descripcion;
  final String img;

  ModuleModel({
    required this.id,
    required this.nombre,
    this.descripcion = "",
    required this.img,
  });

  factory ModuleModel.fromJson(Map<String, dynamic> json) => ModuleModel(
        id: json["Id"],
        nombre: json["Nombre"],
        descripcion: json["Descripcion"] ?? "",
        img: json["Img"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Nombre": nombre,
        "Descripcion": descripcion,
        "Img": img,
      };
}
