// To parse this JSON data, do
//
//     final nannyFavouriteResponseModel = nannyFavouriteResponseModelFromJson(jsonString);

import 'dart:convert';

NannyFavouriteResponseModel nannyFavouriteResponseModelFromJson(String str) =>
    NannyFavouriteResponseModel.fromJson(json.decode(str));

String nannyFavouriteResponseModelToJson(NannyFavouriteResponseModel data) =>
    json.encode(data.toJson());

class NannyFavouriteResponseModel {
  int? response;
  dynamic message;
  bool? data;

  NannyFavouriteResponseModel({
    this.response,
    this.message,
    this.data,
  });

  factory NannyFavouriteResponseModel.fromJson(Map<String, dynamic> json) =>
      NannyFavouriteResponseModel(
        response: json["response"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "message": message,
        "data": data,
      };
}
