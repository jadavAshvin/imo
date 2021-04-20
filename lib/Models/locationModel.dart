class Location {
  Location({
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
  dynamic projectId;
  DateTime createdOn;
  int inventoriesCount;
  dynamic inventories;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        projectId: json["projectId"],
        createdOn: DateTime.parse(json["createdOn"]),
        inventoriesCount: json["inventoriesCount"],
        inventories: json["inventories"],
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
        "inventories": inventories,
      };
}
