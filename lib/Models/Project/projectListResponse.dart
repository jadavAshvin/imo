// To parse this JSON data, do
//
//     final projectList = projectListFromJson(jsonString);

import 'dart:convert';

List<ProjectList> projectListFromJson(String str) => List<ProjectList>.from(json.decode(str).map((x) => ProjectList.fromJson(x)));

String projectListToJson(List<ProjectList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProjectList {
  ProjectList({
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
  dynamic locations;
  int inventoriesCount;
  int locationsCount;

  factory ProjectList.fromJson(Map<String, dynamic> json) => ProjectList(
        id: json["id"],
        name: json["name"],
        createdOn: DateTime.parse(json["createdOn"]),
        locations: json["locations"],
        inventoriesCount: json["inventoriesCount"],
        locationsCount: json["locationsCount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "createdOn": createdOn.toIso8601String(),
        "locations": locations,
        "inventoriesCount": inventoriesCount,
        "locationsCount": locationsCount,
      };
}
