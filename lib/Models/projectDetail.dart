// To parse this JSON data, do
//
//     final projectDetail = projectDetailFromJson(jsonString);

import 'dart:convert';

import 'package:flt_imo/Models/locationModel.dart';

ProjectDetail projectDetailFromJson(String str) => ProjectDetail.fromJson(json.decode(str));

String projectDetailToJson(ProjectDetail data) => json.encode(data.toJson());

class ProjectDetail {
  ProjectDetail({
    this.id,
    this.name,
    this.createdOn,
    this.locations,
    this.inventoriesCount,
    this.locationsCount,
  });

  int id;
  String name;
  DateTime createdOn;
  List<Location> locations;
  int inventoriesCount;
  int locationsCount;

  factory ProjectDetail.fromJson(Map<String, dynamic> json) => ProjectDetail(
        id: json["id"],
        name: json["name"],
        createdOn: DateTime.parse(json["createdOn"]),
        locations: List<Location>.from(json["locations"].map((x) => Location.fromJson(x))),
        inventoriesCount: json["inventoriesCount"],
        locationsCount: json["locationsCount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "createdOn": createdOn.toIso8601String(),
        "locations": List<dynamic>.from(locations.map((x) => x.toJson())),
        "inventoriesCount": inventoriesCount,
        "locationsCount": locationsCount,
      };
}
