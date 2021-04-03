// To parse this JSON data, do
//
//     final locationList = locationListFromJson(jsonString);

import 'dart:convert';

LocationList locationListFromJson(String str) => LocationList.fromJson(json.decode(str));

String locationListToJson(LocationList data) => json.encode(data.toJson());

class LocationList {
  LocationList({
    this.id,
    this.name,
    this.address,
    this.latitude,
    this.longitude,
    this.projectId,
    this.createdOn,
    this.inventoriesCount,
    this.inventories,
  });

  int id;
  String name;
  String address;
  int latitude;
  int longitude;
  int projectId;
  DateTime createdOn;
  int inventoriesCount;
  List<Inventory> inventories;

  factory LocationList.fromJson(Map<String, dynamic> json) => LocationList(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        projectId: json["projectId"],
        createdOn: DateTime.parse(json["createdOn"]),
        inventoriesCount: json["inventoriesCount"],
        inventories: List<Inventory>.from(json["inventories"].map((x) => Inventory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "projectId": projectId,
        "createdOn": createdOn.toIso8601String(),
        "inventoriesCount": inventoriesCount,
        "inventories": List<dynamic>.from(inventories.map((x) => x.toJson())),
      };
}

class Inventory {
  Inventory({
    this.id,
    this.name,
    this.locationId,
    this.projectId,
    this.createdOn,
    this.boxesCount,
    this.boxes,
  });

  int id;
  String name;
  int locationId;
  int projectId;
  DateTime createdOn;
  int boxesCount;
  dynamic boxes;

  factory Inventory.fromJson(Map<String, dynamic> json) => Inventory(
        id: json["id"],
        name: json["name"],
        locationId: json["locationId"],
        projectId: json["projectId"],
        createdOn: DateTime.parse(json["createdOn"]),
        boxesCount: json["boxesCount"],
        boxes: json["boxes"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "locationId": locationId,
        "projectId": projectId,
        "createdOn": createdOn.toIso8601String(),
        "boxesCount": boxesCount,
        "boxes": boxes,
      };
}
