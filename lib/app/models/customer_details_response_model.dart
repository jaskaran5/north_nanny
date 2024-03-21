// To parse this JSON data, do
//
//     final customerDetailsResponseModel = customerDetailsResponseModelFromJson(jsonString);

import 'dart:convert';

CustomerDetailsResponseModel customerDetailsResponseModelFromJson(String str) =>
    CustomerDetailsResponseModel.fromJson(json.decode(str));

String customerDetailsResponseModelToJson(CustomerDetailsResponseModel data) =>
    json.encode(data.toJson());

class CustomerDetailsResponseModel {
  int? response;
  dynamic message;
  Data? data;

  CustomerDetailsResponseModel({
    this.response,
    this.message,
    this.data,
  });

  factory CustomerDetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      CustomerDetailsResponseModel(
        response: json["response"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  String? name;
  dynamic isOnline;
  String? image;

  Data({
    this.name,
    this.isOnline,
    this.image,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        isOnline: json["isOnline"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "isOnline": isOnline,
        "image": image,
      };
}
