import 'dart:convert';

import 'nanny_profile_model.dart';

NannyBookingDetail nannyBookingDetailFromJson(String str) =>
    NannyBookingDetail.fromJson(json.decode(str));

String nannyBookingDetailToJson(NannyBookingDetail data) =>
    json.encode(data.toJson());

class NannyBookingDetail {
  int? response;
  String? message;
  List<NannyBookingDetailData>? data;

  NannyBookingDetail({
    this.response,
    this.message,
    this.data,
  });

  factory NannyBookingDetail.fromJson(Map<String, dynamic> json) =>
      NannyBookingDetail(
          response: json["response"],
          message: json["message"],
          data: json["data"] == null
              ? []
              : List<NannyBookingDetailData>.from(json["data"]!
                  .map((x) => NannyBookingDetailData.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "response": response,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class NannyBookingDetailData {
  DateTime? openingTime;
  DateTime? closingTime;
  double? billAmount;
  int? bookingId;
  List<String>? services;
  int? childCount;
  String? name;
  String? image;
  int? reviewCount;
  double? rating;
  int? bookingStatus;
  List<RatingList>? ratingList;

  NannyBookingDetailData({
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

  factory NannyBookingDetailData.fromJson(Map<String, dynamic> json) =>
      NannyBookingDetailData(
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
        bookingId: json["bookingId"],
        bookingStatus: json["bookingStatus"],
        ratingList: json["ratingList"] == null
            ? []
            : List<RatingList>.from(
                json["ratingList"]!.map((x) => RatingList.fromJson(x))),
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
        "bookingId": bookingId,
        "bookingStatus": bookingStatus,
        "ratingList": ratingList == null
            ? []
            : List<dynamic>.from(ratingList!.map((x) => x.toJson())),
      };
}
