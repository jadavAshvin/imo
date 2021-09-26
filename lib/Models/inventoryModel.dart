import 'dart:convert';

List<Inventory> inventoryFromJson(String str) => List<Inventory>.from(json.decode(str).map((x) => Inventory.fromJson(x)));

String inventoryToJson(List<Inventory> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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

  int? id;
  String? name;
  int? locationId;
  int? projectId;
  DateTime? createdOn;
  int? boxesCount;
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
        "createdOn": createdOn!.toIso8601String(),
        "boxesCount": boxesCount,
        "boxes": boxes,
      };
}
