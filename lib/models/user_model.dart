// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final int id;
  final String usuario;
  final String nombre;
  final String tipoUsuario;
  final Empresa empresa;
  final String token;

  UserModel({
    required this.id,
    required this.usuario,
    required this.nombre,
    required this.tipoUsuario,
    required this.empresa,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["Id"],
        usuario: json["Usuario"],
        nombre: json["Nombre"],
        tipoUsuario: json["TipoUsuario"],
        empresa: Empresa.fromJson(json["Empresa"]),
        token: json["Token"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Usuario": usuario,
        "Nombre": nombre,
        "TipoUsuario": tipoUsuario,
        "Empresa": empresa.toJson(),
        "Token": token,
      };
}

class Empresa {
  final int id;
  final String nombre;
  final int idSuc;
  final int idUsrEmp;

  Empresa({
    required this.id,
    required this.nombre,
    required this.idSuc,
    required this.idUsrEmp,
  });

  factory Empresa.fromJson(Map<String, dynamic> json) => Empresa(
        id: json["Id"],
        nombre: json["Nombre"],
        idSuc: json["IdSuc"],
        idUsrEmp: json["IdUsrEmp"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Nombre": nombre,
        "IdSuc": idSuc,
        "IdUsrEmp": idUsrEmp,
      };
}













/*
import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final int id;
  final String name;
  final String username;
  final String password;
  final String dbname;
  final String token;

  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.password,
    required this.dbname,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        password: json["password"],
        dbname: json["dbname"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "password": password,
        "dbname": dbname,
        "token": token,
      };
}
*/