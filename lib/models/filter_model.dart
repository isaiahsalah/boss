// To parse this JSON data, do
//
//     final filterModel = filterModelFromJson(jsonString);

import 'dart:convert';

FilterModel filterModelFromJson(String str) =>
    FilterModel.fromJson(json.decode(str));

String filterModelToJson(FilterModel data) => json.encode(data.toJson());

class FilterModel {
  final int id;
  final String tipoObjeto;
  final String procedimineto;
  final List<FiltroEspecifico> filtros;

  FilterModel({
    required this.id,
    required this.tipoObjeto,
    required this.procedimineto,
    required this.filtros,
  });

  factory FilterModel.fromJson(Map<String, dynamic> json) => FilterModel(
        id: json["Id"],
        tipoObjeto: json["TipoObjeto"],
        procedimineto: json["Procedimineto"],
        filtros: List<FiltroEspecifico>.from(
            json["Filtros"].map((x) => FiltroEspecifico.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "TipoObjeto": tipoObjeto,
        "Procedimineto": procedimineto,
        "Filtros": List<dynamic>.from(filtros.map((x) => x.toJson())),
      };
}

class FiltroEspecifico {
  final String tipo;
  final String nombre;
  final String variable;
  final String especificacion;
  late String valorInicial;
  final bool obligatorio;
  final List<FuenteDato>? fuenteDatos;

  FiltroEspecifico({
    required this.tipo,
    required this.nombre,
    required this.variable,
    required this.especificacion,
    required this.valorInicial,
    required this.obligatorio,
    this.fuenteDatos,
  });

  factory FiltroEspecifico.fromJson(Map<String, dynamic> json) =>
      FiltroEspecifico(
        tipo: json["Tipo"],
        nombre: json["Nombre"],
        variable: json["Variable"],
        especificacion: json["Especificacion"],
        valorInicial: json["ValorInicial"],
        obligatorio: json["Obligatorio"],
        fuenteDatos: json["FuenteDatos"] == null
            ? []
            : List<FuenteDato>.from(
                json["FuenteDatos"]!.map((x) => FuenteDato.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Tipo": tipo,
        "Nombre": nombre,
        "Variable": variable,
        "Especificacion": especificacion,
        "ValorInicial": valorInicial,
        "Obligatorio": obligatorio,
        "FuenteDatos": fuenteDatos == null
            ? []
            : List<dynamic>.from(fuenteDatos!.map((x) => x.toJson())),
      };
}

class FuenteDato {
  late int id;
  late String nombre;

  FuenteDato({
    required this.id,
    required this.nombre,
  });

  factory FuenteDato.fromJson(Map<String, dynamic> json) => FuenteDato(
        id: json["Id"],
        nombre: json["Nombre"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Nombre": nombre,
      };
}
