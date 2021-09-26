import 'dart:convert';

List<BoxItem> boxItemFromJson(String str) => List<BoxItem>.from(json.decode(str).map((x) => BoxItem.fromJson(x)));

String boxItemToJson(List<BoxItem> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BoxItem {
  BoxItem({
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

  String? key;
  String? title;
  String? description;
  bool? isSaleable;
  int? price;
  bool? isNegotiable;
  bool? isFragile;
  int? quantity;
  List<String>? images;
  DateTime? createdOn;

  factory BoxItem.fromJson(Map<String, dynamic> json) => BoxItem(
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
        "images": List<dynamic>.from(images!.map((x) => x)),
        "createdOn": createdOn!.toIso8601String(),
      };
}
