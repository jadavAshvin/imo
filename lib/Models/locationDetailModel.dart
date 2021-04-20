import 'dart:convert';

import 'package:flt_imo/Models/inventoryModel.dart';

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
  dynamic latitude;
  dynamic longitude;
  int projectId;
  DateTime createdOn;
  dynamic inventoriesCount;
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
