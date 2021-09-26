// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileModel({
    this.userId,
    this.givenName,
    this.phoneNumber,
    this.emailAddress,
    this.profilePicture,
    this.address,
    this.isSuccess,
    this.message,
    this.status,
    this.gender,
  });

  String? userId;
  String? givenName;
  String? phoneNumber;
  String? emailAddress;
  dynamic profilePicture;
  Address? address;
  bool? isSuccess;
  String? message;
  String? gender;
  dynamic status;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        userId: json["userId"],
        givenName: json["givenName"],
        phoneNumber: json["phoneNumber"],
        emailAddress: json["emailAddress"],
        profilePicture: json["profilePicture"],
        address: json["address"] == null ? Address(country: "", postalCode: "", region: "", streetAddress: "") : Address.fromJson(json["address"]),
        isSuccess: json["isSuccess"],
        message: json["message"],
        status: json["status"],
        gender: json["gender"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "givenName": givenName,
        "phoneNumber": phoneNumber,
        "emailAddress": emailAddress,
        "profilePicture": profilePicture,
        "address": address!.toJson(),
        "isSuccess": isSuccess,
        "message": message,
        "status": status,
      };
}

class Address {
  Address({
    this.streetAddress,
    this.region,
    this.country,
    this.postalCode,
  });

  String? streetAddress;
  String? region;
  String? country;
  String? postalCode;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        streetAddress: json["street_address"],
        region: json["region"],
        country: json["country"],
        postalCode: json["postal_code"],
      );

  Map<String, dynamic> toJson() => {
        "street_address": streetAddress,
        "region": region,
        "country": country,
        "postal_code": postalCode,
      };
}
