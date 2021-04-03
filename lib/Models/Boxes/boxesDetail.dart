// To parse this JSON data, do
//
//     final boxDetail = boxDetailFromJson(jsonString);

import 'dart:convert';

BoxDetail boxDetailFromJson(String str) => BoxDetail.fromJson(json.decode(str));

String boxDetailToJson(BoxDetail data) => json.encode(data.toJson());

class BoxDetail {
  BoxDetail({
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
    this.items,
    this.createdOn,
  });

  String key;
  dynamic inventoryId;
  String title;
  String description;
  String uniqueQrCode;
  bool isSaleable;
  int price;
  bool isNegotiable;
  int weight;
  int length;
  int width;
  int height;
  List<Item> items;
  DateTime createdOn;

  factory BoxDetail.fromJson(Map<String, dynamic> json) => BoxDetail(
        key: json["key"],
        inventoryId: json["inventoryId"],
        title: json["title"],
        description: json["description"],
        uniqueQrCode: json["uniqueQrCode"],
        isSaleable: json["isSaleable"],
        price: json["price"],
        isNegotiable: json["isNegotiable"],
        weight: json["weight"],
        length: json["length"],
        width: json["width"],
        height: json["height"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
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
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "createdOn": createdOn.toIso8601String(),
      };
}

class Item {
  Item({
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

  factory Item.fromJson(Map<String, dynamic> json) => Item(
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
