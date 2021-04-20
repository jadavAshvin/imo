// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.tokens,
    this.userId,
    this.emailAddress,
    this.isSuccess,
    this.message,
    this.status,
  });

  Tokens tokens;
  String userId;
  String emailAddress;
  bool isSuccess;
  dynamic message;
  dynamic status;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        tokens: Tokens.fromJson(json["tokens"]),
        userId: json["userId"],
        emailAddress: json["emailAddress"],
        isSuccess: json["isSuccess"],
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "tokens": tokens.toJson(),
        "userId": userId,
        "emailAddress": emailAddress,
        "isSuccess": isSuccess,
        "message": message,
        "status": status,
      };
}

class Tokens {
  Tokens({
    this.idToken,
    this.refreshToken,
    this.expiresIn,
    this.accessToken,
  });

  String idToken;
  String refreshToken;
  int expiresIn;
  String accessToken;

  factory Tokens.fromJson(Map<String, dynamic> json) => Tokens(
        idToken: json["idToken"],
        refreshToken: json["refreshToken"],
        expiresIn: json["expiresIn"],
        accessToken: json["accessToken"],
      );

  Map<String, dynamic> toJson() => {
        "idToken": idToken,
        "refreshToken": refreshToken,
        "expiresIn": expiresIn,
        "accessToken": accessToken,
      };
}
