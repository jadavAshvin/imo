// To parse this JSON data, do
//
//     final projectList = projectListFromJson(jsonString);

import 'dart:convert';

List<Project> projectFromJson(String str) => List<Project>.from(json.decode(str).map((x) => Project.fromJson(x)));

String projectToJson(List<Project> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Project {
  Project({
    this.id,
    this.name,
    this.createdOn,
    this.locations,
    this.inventoriesCount,
    this.locationsCount,
    this.description,
  });

  int id;
  String name;
  DateTime createdOn;
  dynamic locations;
  int inventoriesCount;
  int locationsCount;
  String description;

  factory Project.fromJson(Map<String, dynamic> json) => Project(
        id: json["id"],
        name: json["name"],
        createdOn: DateTime.parse(json["createdOn"]),
        locations: json["locations"],
        inventoriesCount: json["inventoriesCount"],
        locationsCount: json["locationsCount"],
        description: json["description"] == null ? "N/A" : json["description"],
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
