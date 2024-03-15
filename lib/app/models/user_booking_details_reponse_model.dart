// To parse this JSON data, do
//
//     final userBookingDetailsResponseModel = userBookingDetailsResponseModelFromJson(jsonString);

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
  List<UserBookingData>? data;

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
            : List<UserBookingData>.from(
                json["data"]!.map((x) => UserBookingData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class UserBookingData {
  DateTime? openingTime;
  DateTime? closingTime;
  dynamic billAmount;
  List<String>? services;
  dynamic childCount;
  String? name;
  String? image;
  dynamic reviewCount;
  dynamic rating;
  dynamic bookingStatus;
  dynamic ratingList;
  dynamic bookingId;

  UserBookingData({
    this.openingTime,
    this.closingTime,
    this.billAmount,
    this.services,
    this.childCount,
    this.name,
    this.image,
    this.reviewCount,
    this.rating,
    this.bookingStatus,
    this.ratingList,
    this.bookingId,
  });

  factory UserBookingData.fromJson(Map<String, dynamic> json) =>
      UserBookingData(
        openingTime: json["openingTime"] == null
            ? null
            : DateTime.parse(json["openingTime"]),
        closingTime: json["closingTime"] == null
            ? null
            : DateTime.parse(json["closingTime"]),
        billAmount: json["billAmount"],
        services: json["services"] == null
            ? []
            : List<String>.from(json["services"]!.map((x) => x)),
        childCount: json["childCount"],
        name: json["name"],
        image: json["image"],
        reviewCount: json["reviewCount"],
        rating: json["rating"],
        bookingStatus: json["bookingStatus"],
        ratingList: json["ratingList"],
        bookingId: json["bookingId"],
      );

  Map<String, dynamic> toJson() => {
        "openingTime": openingTime?.toIso8601String(),
        "closingTime": closingTime?.toIso8601String(),
        "billAmount": billAmount,
        "services":
            services == null ? [] : List<dynamic>.from(services!.map((x) => x)),
        "childCount": childCount,
        "name": name,
        "image": image,
        "reviewCount": reviewCount,
        "rating": rating,
        "bookingStatus": bookingStatus,
        "ratingList": ratingList,
        "bookingId": bookingId,
      };
}
