// To parse this JSON data, do
//
//     final inventoryDetail = inventoryDetailFromJson(jsonString);

import 'dart:convert';

InventoryDetail inventoryDetailFromJson(String str) => InventoryDetail.fromJson(json.decode(str));

String inventoryDetailToJson(InventoryDetail data) => json.encode(data.toJson());

class InventoryDetail {
  InventoryDetail({
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
  dynamic locationId;
  int projectId;
  DateTime createdOn;
  int boxesCount;
  List<Box> boxes;

  factory InventoryDetail.fromJson(Map<String, dynamic> json) => InventoryDetail(
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
        "createdOn": createdOn.toIso8601String(),
        "boxesCount": boxesCount,
        "boxes": List<dynamic>.from(boxes.map((x) => x.toJson())),
      };
}

class Box {
  Box({
    this.key,
    this.inventoryId,
    this.title,
    this.description,
    this.uniqueQrCode,
    this.isSaleable,
    this.price,
    this.isNegotiable,
    this.weight,
    this.length,
    this.width,
    this.height,
    this.iteminventorys,
    this.createdOn,
  });

  String key;
  dynamic inventoryId;
  String title;
  String description;
  String uniqueQrCode;
  bool isSaleable;
  double price;
  bool isNegotiable;
  double weight;
  double length;
  double width;
  double height;
  List<ItemInventory> iteminventorys;
  DateTime createdOn;

  factory Box.fromJson(Map<String, dynamic> json) => Box(
        key: json["key"],
        inventoryId: json["inventoryId"],
        title: json["title"],
        description: json["description"],
        uniqueQrCode: json["uniqueQrCode"],
        isSaleable: json["isSaleable"],
        price: double.parse(json["price"].toString()),
        isNegotiable: json["isNegotiable"],
        weight: double.parse(json["weight"].toString()),
        length: double.parse(json["length"].toString()),
        width: double.parse(json["width"].toString()),
        height: double.parse(json["height"].toString()),
        iteminventorys: json["items"] == null ? [] : List<ItemInventory>.from(json["items"].map((x) => ItemInventory.fromJson(x))),
        createdOn: DateTime.parse(json["createdOn"]),
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "inventoryId": inventoryId,
        "title": title,
        "description": description,
        "uniqueQrCode": uniqueQrCode,
        "isSaleable": isSaleable,
        "price": price,
        "isNegotiable": isNegotiable,
        "weight": weight,
        "length": length,
        "width": width,
        "height": height,
        "items": List<dynamic>.from(iteminventorys.map((x) => x.toJson())),
        "createdOn": createdOn.toIso8601String(),
      };
}

class ItemInventory {
  ItemInventory({
    this.key,
    this.title,
    this.description,
    this.isSaleable,
    this.price,
    this.isNegotiable,
    this.isFragile,
    this.quantity,
    this.images,
    this.createdOn,
  });

  String key;
  String title;
  String description;
  bool isSaleable;
  int price;
  bool isNegotiable;
  bool isFragile;
  int quantity;
  List<String> images;
  DateTime createdOn;

  factory ItemInventory.fromJson(Map<String, dynamic> json) => ItemInventory(
        key: json["key"],
        title: json["title"],
        description: json["description"],
        isSaleable: json["isSaleable"],
        price: json["price"],
        isNegotiable: json["isNegotiable"],
        isFragile: json["isFragile"],
        quantity: json["quantity"],
        images: List<String>.from(json["images"].map((x) => x)),
        createdOn: DateTime.parse(json["createdOn"]),
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "title": title,
        "description": description,
        "isSaleable": isSaleable,
        "price": price,
        "isNegotiable": isNegotiable,
        "isFragile": isFragile,
        "quantity": quantity,
        "images": List<dynamic>.from(images.map((x) => x)),
        "createdOn": createdOn.toIso8601String(),
      };
}
