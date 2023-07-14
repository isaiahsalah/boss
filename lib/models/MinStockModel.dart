// To parse this JSON data, do
//
//     final minStockModel = minStockModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

MinStockModel minStockModelFromJson(String str) =>
    MinStockModel.fromJson(json.decode(str));

String minStockModelToJson(MinStockModel data) => json.encode(data.toJson());

class MinStockModel {
  final String company;
  final String description;
  final List<Branch> branch;

  MinStockModel({
    required this.company,
    required this.description,
    required this.branch,
  });

  factory MinStockModel.fromJson(Map<String, dynamic> json) => MinStockModel(
        company: json["company"],
        description: json["description"],
        branch:
            List<Branch>.from(json["branch"].map((x) => Branch.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "company": company,
        "description": description,
        "branch": List<dynamic>.from(branch.map((x) => x.toJson())),
      };
}

class Branch {
  final String name;
  final String description;
  final List<Item> items;

  Branch({
    required this.name,
    required this.description,
    required this.items,
  });

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        name: json["name"],
        description: json["description"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class Item {
  final String id;
  final String name;
  final int stock;
  final int minStock;

  Item({
    required this.id,
    required this.name,
    required this.stock,
    required this.minStock,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        name: json["name"],
        stock: json["stock"],
        minStock: json["minStock"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "stock": stock,
        "minStock": minStock,
      };
}
