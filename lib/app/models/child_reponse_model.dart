// To parse this JSON data, do
//
//     final childResponseModel = childResponseModelFromJson(jsonString);

import 'dart:convert';

ChildResponseModel childResponseModelFromJson(String str) =>
    ChildResponseModel.fromJson(json.decode(str));

String childResponseModelToJson(ChildResponseModel data) =>
    json.encode(data.toJson());

class ChildResponseModel {
  int? response;
  String? message;
  dynamic data;

  ChildResponseModel({
    this.response,
    this.message,
    this.data,
  });

  factory ChildResponseModel.fromJson(Map<String, dynamic> json) =>
      ChildResponseModel(
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
