// To parse this JSON data, do
//
//     final requestModel = requestModelFromJson(jsonString);

import 'dart:convert';

RequestModel requestModelFromJson(String str) =>
    RequestModel.fromJson(json.decode(str));

String requestModelToJson(RequestModel data) => json.encode(data.toJson());

class RequestModel {
  final int id;
  final String tipo;
  final List<RequestVariable> variables;

  RequestModel({
    required this.id,
    required this.tipo,
    required this.variables,
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) => RequestModel(
        id: json["id"],
        tipo: json["tipo"],
        variables: List<RequestVariable>.from(
            json["variables"].map((x) => RequestVariable.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
        "variables": List<dynamic>.from(variables.map((x) => x.toJson())),
      };
}

class RequestVariable {
  final String nombre;
  final String valor;

  RequestVariable({
    required this.nombre,
    required this.valor,
  });

  factory RequestVariable.fromJson(Map<String, dynamic> json) =>
      RequestVariable(
        nombre: json["nombre"],
        valor: json["valor"],
      );

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "valor": valor,
      };
}
