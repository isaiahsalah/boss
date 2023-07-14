// To parse this JSON data, do
//
//     final boxesModel = boxesModelFromJson(jsonString);

import 'dart:convert';

BoxesModel boxesModelFromJson(String str) =>
    BoxesModel.fromJson(json.decode(str));

String boxesModelToJson(BoxesModel data) => json.encode(data.toJson());

class BoxesModel {
  final String company;
  final String description;
  final List<Branch> branches;

  BoxesModel({
    required this.company,
    required this.description,
    required this.branches,
  });

  factory BoxesModel.fromJson(Map<String, dynamic> json) => BoxesModel(
        company: json["company"],
        description: json["description"],
        branches:
            List<Branch>.from(json["branches"].map((x) => Branch.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "company": company,
        "description": description,
        "branches": List<dynamic>.from(branches.map((x) => x.toJson())),
      };
}

class Branch {
  final String title;
  final String description;
  final List<Box> boxes;

  Branch({
    required this.title,
    required this.description,
    required this.boxes,
  });

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        title: json["title"],
        description: json["description"],
        boxes: List<Box>.from(json["boxes"].map((x) => Box.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "boxes": List<dynamic>.from(boxes.map((x) => x.toJson())),
      };
}

class Box {
  final String title;
  final String description;
  final String branch;

  final int value;

  Box({
    required this.title,
    required this.description,
    required this.branch,
    required this.value,
  });

  factory Box.fromJson(Map<String, dynamic> json) => Box(
        title: json["title"],
        description: json["description"],
        branch: json["branch"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "branch": branch,
        "value": value,
      };
}
