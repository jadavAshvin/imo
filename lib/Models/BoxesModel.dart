// To parse this JSON data, do
//
//     final boxes = boxesFromJson(jsonString);

import 'dart:convert';

List<Boxes> boxesFromJson(String str) => List<Boxes>.from(json.decode(str).map((x) => Boxes.fromJson(x)));

String boxesToJson(List<Boxes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Boxes {
  Boxes({
    this.boxDocumentKey,
    this.inventoryId,
    this.createdOn,
    this.userId,
    this.inventory,
    this.usermaster,
  });

  String boxDocumentKey;
  int inventoryId;
  DateTime createdOn;
  String userId;
  dynamic inventory;
  dynamic usermaster;

  factory Boxes.fromJson(Map<String, dynamic> json) => Boxes(
        boxDocumentKey: json["boxDocumentKey"],
        inventoryId: json["inventoryId"],
        createdOn: DateTime.parse(json["createdOn"]),
        userId: json["userId"],
        inventory: json["inventory"],
        usermaster: json["usermaster"],
      );

  Map<String, dynamic> toJson() => {
        "boxDocumentKey": boxDocumentKey,
        "inventoryId": inventoryId,
        "createdOn": createdOn.toIso8601String(),
        "userId": userId,
        "inventory": inventory,
        "usermaster": usermaster,
      };
}
