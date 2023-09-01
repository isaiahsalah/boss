// To parse this JSON data, do
//
//     final prefModel = prefModelFromJson(jsonString);

import 'dart:convert';

import 'package:boss/models/widgets/widget_model.dart';

UserPrefModel userPrefModelFromJson(String str) =>
    UserPrefModel.fromJson(json.decode(str));

String userPrefModelToJson(UserPrefModel data) => json.encode(data.toJson());

class UserPrefModel {
  final DateTime dateIni;
  final DateTime dateEnd;
  final List<WidgetModel> widgets;

  UserPrefModel({
    required this.dateIni,
    required this.dateEnd,
    required this.widgets,
  });

  factory UserPrefModel.fromJson(Map<String, dynamic> json) => UserPrefModel(
        dateIni: DateTime.parse(json["dateIni"]),
        dateEnd: DateTime.parse(json["dateEnd"]),
        widgets: List<WidgetModel>.from(
            json["widgets"].map((x) => WidgetModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "dateIni": dateIni.toIso8601String(),
        "dateEnd": dateEnd.toIso8601String(),
        "widgets": List<dynamic>.from(widgets.map((x) => x.toJson())),
      };
}
