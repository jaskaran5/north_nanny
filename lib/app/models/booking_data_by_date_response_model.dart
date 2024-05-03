import 'dart:convert';

import 'package:northshore_nanny_flutter/app/models/booking_details_model.dart';
import 'package:northshore_nanny_flutter/app/models/nanny_profile_model.dart';

BookingDataByIdResponseModel bookingDataByIdResponseModelFromJson(String str) =>
    BookingDataByIdResponseModel.fromJson(json.decode(str));

String bookingDataByIdResponseModelToJson(BookingDataByIdResponseModel data) =>
    json.encode(data.toJson());

class BookingDataByIdResponseModel {
  int? response;
  dynamic message;
  BookingDataById? data;

  BookingDataByIdResponseModel({
    this.response,
    this.message,
    this.data,
  });

  factory BookingDataByIdResponseModel.fromJson(Map<String, dynamic> json) =>
      BookingDataByIdResponseModel(
        response: json["response"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : BookingDataById.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "message": message,
        "data": data?.toJson(),
      };
}

class BookingDataById {
  int? bookingStatus;
  int? bookingId;
  dynamic hourlyPrice;
  int? userId;
  String? location;
  String? latitude;
  String? longitude;
  DateTime? bookingDate;
  DateTime? openingDate;
  DateTime? closingDate;
  DateTime? startTime;
  DateTime? endTime;
  List<String>? servicesType;
  List<Child>? children;
  UserDetails? userDetails;
  int? totalChildren;
  int? totalHour;
  double? totalAmount;
  dynamic userReviewList;
  bool? isJobStarted;
  bool? isUseReferrals;
  bool? isCardAddedByCustomer;
  RatingList? reviewGivenByMe;
  RatingList? reviewGivenByOther;
  bool? isSendTip;

  BookingDataById({
    this.bookingStatus,
    this.bookingId,
    this.hourlyPrice,
    this.userId,
    this.location,
    this.latitude,
    this.longitude,
    this.bookingDate,
    this.openingDate,
    this.closingDate,
    this.startTime,
    this.servicesType,
    this.children,
    this.userDetails,
    this.totalChildren,
    this.totalHour,
    this.totalAmount,
    this.userReviewList,
    this.isJobStarted,
    this.isUseReferrals,
    this.isCardAddedByCustomer,
    this.reviewGivenByMe,
    this.reviewGivenByOther,
    this.isSendTip,
    this.endTime,
  });

  factory BookingDataById.fromJson(Map<String, dynamic> json) =>
      BookingDataById(
        bookingStatus: json["bookingStatus"],
        bookingId: json["bookingId"],
        hourlyPrice: json["hourlyprice"],
        userId: json["userId"],
        location: json["location"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        bookingDate: json["bookingDate"] == null
            ? null
            : DateTime.parse(json["bookingDate"]),
        openingDate: json["openingDate"] == null
            ? null
            : DateTime.parse(json["openingDate"]),
        closingDate: json["closingDate"] == null
            ? null
            : DateTime.parse(json["closingDate"]),
        startTime: json["startTime"] == null
            ? null
            : DateTime.parse(json["startTime"]),
        endTime:
            json["endTime"] == null ? null : DateTime.parse(json["endTime"]),
        servicesType: json["servicesType"] == null
            ? []
            : List<String>.from(json["servicesType"]!.map((x) => x)),
        children: json["children"] == null
            ? []
            : List<Child>.from(json["children"]!.map((x) => Child.fromJson(x))),
        userDetails: json["userDetails"] == null
            ? null
            : UserDetails.fromJson(json["userDetails"]),
        totalChildren: json["totalChildern"],
        totalHour: json["totalHour"],
        totalAmount: json["totalAmount"]?.toDouble(),
        userReviewList: json["userReviewList"],
        isJobStarted: json["isJobStarted"],
        isUseReferrals: json["isUseReferals"],
        isCardAddedByCustomer: json["isCardAddedByCustomer"],
        reviewGivenByMe: json["reviewGivenByMe"] == null
            ? null
            : RatingList.fromJson(json["reviewGivenByMe"]),
        reviewGivenByOther: json["reviewGivenByOther"] == null
            ? null
            : RatingList.fromJson(json["reviewGivenByOther"]),
        isSendTip: json["isSendTip"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "bookingStatus": bookingStatus,
        "bookingId": bookingId,
        "hourlyprice": hourlyPrice,
        "userId": userId,
        "location": location,
        "latitude": latitude,
        "longitude": longitude,
        "bookingDate": bookingDate?.toIso8601String(),
        "openingDate": openingDate?.toIso8601String(),
        "closingDate": closingDate?.toIso8601String(),
        "startTime": startTime?.toIso8601String(),
        "endTime": endTime?.toIso8601String(),
        "servicesType": servicesType == null
            ? []
            : List<dynamic>.from(servicesType!.map((x) => x)),
        "children":
            children == null ? [] : List<dynamic>.from(children!.map((x) => x)),
        "userDetails": userDetails?.toJson(),
        "totalChildern": totalChildren,
        "totalHour": totalHour,
        "totalAmount": totalAmount,
        "userReviewList": userReviewList,
        "isJobStarted": isJobStarted,
        "isUseReferals": isUseReferrals,
        "isCardAddedByCustomer": isCardAddedByCustomer,
        "reviewGivenByMe": reviewGivenByMe?.toJson(),
        "reviewGivenByOther": reviewGivenByOther?.toJson(),
        "isSendTip": isSendTip,
      };
}

class UserDetails {
  int? userId;
  String? name;
  String? image;
  dynamic rating;
  dynamic review;
  String? location;
  String? latitude;
  String? longitude;
  String? aboutMe;
  int? reviewCount;
  int? age;
  int? gender;
  dynamic distance;
  String? experience;
  List<RatingList>? ratingList;

  UserDetails({
    this.userId,
    this.name,
    this.image,
    this.rating,
    this.review,
    this.location,
    this.latitude,
    this.longitude,
    this.aboutMe,
    this.reviewCount,
    this.age,
    this.distance,
    this.experience,
    this.ratingList,
    this.gender,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        userId: json["userId"],
        name: json["name"],
        image: json["image"],
        rating: json["rating"],
        review: json["review"],
        location: json["location"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        aboutMe: json["aboutMe"],
        reviewCount: json["reviewCount"],
        age: json["age"],
        gender: json["gender"],
        distance: json["diatance"],
        experience: json["experience"],
        ratingList: json["ratingList"] == null
            ? []
            : List<RatingList>.from(
                json["ratingList"]!.map((x) => RatingList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "name": name,
        "image": image,
        "rating": rating,
        "review": review,
        "location": location,
        "latitude": latitude,
        "longitude": longitude,
        "aboutMe": aboutMe,
        "reviewCount": reviewCount,
        "age": age,
        "gender": gender,
        "diatance": distance,
        "experience": experience,
        "ratingList": ratingList == null
            ? []
            : List<dynamic>.from(ratingList!.map((x) => x.toJson())),
      };
}
