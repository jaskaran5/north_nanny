// To parse this JSON data, do
//
//     final userBookingDetailsByDateResponseModel = userBookingDetailsByDateResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:northshore_nanny_flutter/app/models/rating_review_reponse_model.dart';

UserBookingDetailsByDateResponseModel
    userBookingDetailsByDateResponseModelFromJson(String str) =>
        UserBookingDetailsByDateResponseModel.fromJson(json.decode(str));

String userBookingDetailsByDateResponseModelToJson(
        UserBookingDetailsByDateResponseModel data) =>
    json.encode(data.toJson());

class UserBookingDetailsByDateResponseModel {
  int? response;
  dynamic message;
  UserBookingDataByDate? data;

  UserBookingDetailsByDateResponseModel({
    this.response,
    this.message,
    this.data,
  });

  factory UserBookingDetailsByDateResponseModel.fromJson(
          Map<String, dynamic> json) =>
      UserBookingDetailsByDateResponseModel(
        response: json["response"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : UserBookingDataByDate.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "message": message,
        "data": data?.toJson(),
      };
}

class UserBookingDataByDate {
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
  List<RatingList>? ratingList;
  dynamic bookingId;
  dynamic aboutMe;

  UserBookingDataByDate({
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
    this.aboutMe,
  });

  factory UserBookingDataByDate.fromJson(Map<String, dynamic> json) =>
      UserBookingDataByDate(
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
        aboutMe: json["about"],
        image: json["image"],
        reviewCount: json["reviewCount"],
        rating: json["rating"],
        bookingStatus: json["bookingStatus"],
        ratingList: json["ratingList"] == null
            ? []
            : List<RatingList>.from(json["ratingList"]!.map((x) => x)),
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
        "ratingList": ratingList == null
            ? []
            : List<RatingList>.from(ratingList!.map((x) => x)),
        "bookingId": bookingId,
        "aboutMe": aboutMe,
      };
}
