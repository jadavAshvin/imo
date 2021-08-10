// To parse this JSON data, do
//
//     final inventoryDetail = inventoryDetailFromJson(jsonString);

import 'dart:convert';

import 'package:flt_imo/Models/BoxModel.dart';

AllInventoryModel allInventoryFromJson(String str) => AllInventoryModel.fromJson(json.decode(str));

String inventoryDetailToJson(AllInventoryModel data) => json.encode(data.toJson());

class AllInventoryModel {
  AllInventoryModel({
    this.id,
    this.name,
    this.locationId,
    this.projectId,
    this.createdOn,
    this.boxesCount,
    this.boxes,
  });

  int? id;
  String? name;
  dynamic locationId;
  int? projectId;
  DateTime? createdOn;
  int? boxesCount;
  List<Box>? boxes;

  factory AllInventoryModel.fromJson(Map<String, dynamic> json) => AllInventoryModel(
        id: json["id"],
        name: json["name"],
        locationId: json["locationId"],
        projectId: json["projectId"],
        createdOn: DateTime.parse(json["createdOn"]),
        boxesCount: json["boxesCount"],
        boxes: json["boxes"] == null ? [] : List<Box>.from(json["boxes"].map((x) => Box.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "locationId": locationId,
        "projectId": projectId,
        "createdOn": createdOn!.toIso8601String(),
        "boxesCount": boxesCount,
        "boxes": List<dynamic>.from(boxes!.map((x) => x.toJson())),
      };
}
