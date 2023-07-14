// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final String name;
  final String lastName;
  final String userName;

  UserModel({
    required this.name,
    required this.lastName,
    required this.userName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        lastName: json["lastName"],
        userName: json["userName"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "lastName": lastName,
        "userName": userName,
      };
}
