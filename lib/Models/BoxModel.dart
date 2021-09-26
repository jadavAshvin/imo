import 'dart:convert';

import 'package:flt_imo/Models/boxItemModel.dart';

List<Box> boxFromJson(String str) => List<Box>.from(json.decode(str).map((x) => Box.fromJson(x)));

String boxToJson(List<Box> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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
    this.boxItem,
    this.createdOn,
  });

  String? key;
  dynamic inventoryId;
  String? title;
  String? description;
  String? uniqueQrCode;
  bool? isSaleable;
  double? price;
  bool? isNegotiable;
  double? weight;
  double? length;
  double? width;
  double? height;
  List<BoxItem>? boxItem;
  DateTime? createdOn;

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
        boxItem: json["items"] == null ? [] : List<BoxItem>.from(json["items"].map((x) => BoxItem.fromJson(x))),
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
        "items": List<dynamic>.from(boxItem!.map((x) => x.toJson())),
        "createdOn": createdOn!.toIso8601String(),
      };
}
