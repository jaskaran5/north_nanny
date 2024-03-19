

import 'dart:convert';

UserBookingDetailsResponseModel userBookingDetailsResponseModelFromJson(
        String str) =>
    UserBookingDetailsResponseModel.fromJson(json.decode(str));

String userBookingDetailsResponseModelToJson(
        UserBookingDetailsResponseModel data) =>
    json.encode(data.toJson());

class UserBookingDetailsResponseModel {
  int? response;
  dynamic message;
  List<DateTime>? data;

  UserBookingDetailsResponseModel({
    this.response,
    this.message,
    this.data,
  });

  factory UserBookingDetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      UserBookingDetailsResponseModel(
        response: json["response"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<DateTime>.from(json["data"]!.map((x) => DateTime.parse(x))),
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toIso8601String())),
      };
}
