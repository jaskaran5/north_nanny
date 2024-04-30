// To parse this JSON data, do
//
//     final nannyDashboardModel = nannyDashboardModelFromJson(jsonString);

import 'dart:convert';

import 'package:northshore_nanny_flutter/app/models/nanny_profile_model.dart';

NannyDashboardModel nannyDashboardModelFromJson(String str) =>
    NannyDashboardModel.fromJson(json.decode(str));

String nannyDashboardModelToJson(NannyDashboardModel data) =>
    json.encode(data.toJson());

class NannyDashboardModel {
  int? response;
  String? message;
  Data? data;

  NannyDashboardModel({
    this.response,
    this.message,
    this.data,
  });

  factory NannyDashboardModel.fromJson(Map<String, dynamic> json) =>
      NannyDashboardModel(
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
  bool? isAvailable;
  String? address;
  String? name;
  double? totalRevenue;
  List<BookingRequest>? bookingRequest;

  Data({
    this.isAvailable,
    this.address,
    this.name,
    this.totalRevenue,
    this.bookingRequest,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        isAvailable: json["isAvailable"],
        address: json["address"] ?? '',
        name: json["name"] ?? '',
        totalRevenue: json["totalRevenue"],
        bookingRequest: json["bookingRequest"] == null
            ? []
            : List<BookingRequest>.from(
                json["bookingRequest"]!.map((x) => BookingRequest.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "isAvailable": isAvailable,
        "address": address,
        "name": name,
        "totalRevenue": totalRevenue,
        "bookingRequest": bookingRequest == null
            ? []
            : List<dynamic>.from(bookingRequest!.map((x) => x.toJson())),
      };
}

class BookingRequest {
  int? bookingId;
  String? name;
  String? image;
  double? rating;
  int? reviewCount;
  double? price;
  double? distance;
  int? bookingStatus;
  int? numberOfChildren;
  DateTime? bookingDate;
  DateTime? openingDate;
  DateTime? closingDate;
  List<RatingList>? userReviewList;

  BookingRequest({
    this.bookingId,
    this.name,
    this.image,
    this.rating,
    this.reviewCount,
    this.price,
    this.distance,
    this.numberOfChildren,
    this.bookingDate,
    this.openingDate,
    this.closingDate,
    this.userReviewList,
    this.bookingStatus,
  });

  factory BookingRequest.fromJson(Map<String, dynamic> json) => BookingRequest(
        bookingId: json["bookingId"],
        name: json["name"] ?? '',
        image: json["image"],
        rating: json["rating"],
        reviewCount: json["reviewcount"],
        price: json["price"],
        distance: json["distance"],
        numberOfChildren: json["numberOfChilderen"],
        bookingStatus: json['bookingStatus'],
        bookingDate: json["bookingDate"] == null
            ? null
            : DateTime.parse(json["bookingDate"]),
        openingDate: json["openingDate"] == null
            ? null
            : DateTime.parse(json["openingDate"]),
        closingDate: json["closingDate"] == null
            ? null
            : DateTime.parse(json["closingDate"]),
        userReviewList: json["userReviewList"] == null
            ? []
            : List<RatingList>.from(
                json["userReviewList"]!.map((x) => RatingList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "bookingId": bookingId,
        "bookingStatus": bookingStatus,
        "name": name,
        "image": image,
        "rating": rating,
        "reviewcount": reviewCount,
        "price": price,
        "distance": distance,
        "numberOfChilderen": numberOfChildren,
        "bookingDate": bookingDate?.toIso8601String(),
        "openingDate": openingDate?.toIso8601String(),
        "closingDate": closingDate?.toIso8601String(),
        "userReviewList": userReviewList == null
            ? []
            : List<dynamic>.from(userReviewList!.map((x) => x.toJson())),
      };
}
