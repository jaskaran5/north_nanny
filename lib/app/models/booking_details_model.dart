import 'dart:convert';

import 'package:northshore_nanny_flutter/app/models/nanny_profile_model.dart';

BookingDetailsModel bookingDetailsModelFromJson(String str) =>
    BookingDetailsModel.fromJson(json.decode(str));

String bookingDetailsModelToJson(BookingDetailsModel data) =>
    json.encode(data.toJson());

class BookingDetailsModel {
  int? response;
  String? message;
  Data? data;

  BookingDetailsModel({
    this.response,
    this.message,
    this.data,
  });

  factory BookingDetailsModel.fromJson(Map<String, dynamic> json) =>
      BookingDetailsModel(
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
  int? userId;
  int? bookingId;
  String? location;
  String? latitude;
  String? longitude;
  DateTime? bookingDate;
  DateTime? openingDate;
  DateTime? closingDate;
  List<String>? servicesType;
  List<Child>? children;
  UserDetails? userDetails;
  int? totalChildren;
  int? totalHour;
  double? totalAmount;
  List<RatingList>? userReviewList;

  Data({
    this.userId,
    this.location,
    this.latitude,
    this.longitude,
    this.bookingDate,
    this.openingDate,
    this.closingDate,
    this.servicesType,
    this.children,
    this.userDetails,
    this.totalChildren,
    this.totalHour,
    this.totalAmount,
    this.userReviewList,
    this.bookingId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["userId"],
        bookingId: json["bookingId"],
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
        totalAmount: json["totalAmount"],
        userReviewList: json["userReviewList"] == null
            ? []
            : List<RatingList>.from(
                json["userReviewList"]!.map((x) => RatingList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "bookingId": bookingId,
        "location": location,
        "latitude": latitude,
        "longitude": longitude,
        "bookingDate": bookingDate?.toIso8601String(),
        "openingDate": openingDate?.toIso8601String(),
        "closingDate": closingDate?.toIso8601String(),
        "servicesType": servicesType == null
            ? []
            : List<dynamic>.from(servicesType!.map((x) => x)),
        "children": children == null
            ? []
            : List<dynamic>.from(children!.map((x) => x.toJson())),
        "userDetails": userDetails?.toJson(),
        "totalChildern": totalChildren,
        "totalHour": totalHour,
        "totalAmount": totalAmount,
        "userReviewList": userReviewList == null
            ? []
            : List<dynamic>.from(userReviewList!.map((x) => x.toJson())),
      };
}

class Child {
  String? name;
  String? age;
  int? gender;
  String? allergiesDietaryAndRestrictions;
  String? medicalCondition;
  String? aboutChild;
  bool? isExpand;

  Child({
    this.name,
    this.age,
    this.gender,
    this.allergiesDietaryAndRestrictions,
    this.medicalCondition,
    this.aboutChild,
    this.isExpand = false,
  });

  factory Child.fromJson(Map<String, dynamic> json) => Child(
        name: json["name"],
        age: json["age"],
        gender: json["gender"],
        allergiesDietaryAndRestrictions:
            json["allergiesDietaryAndRestrictions"],
        medicalCondition: json["medicalCondition"],
        aboutChild: json["aboutChild"],
        isExpand: json["isExpand"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "age": age,
        "gender": gender,
        "allergiesDietaryAndRestrictions": allergiesDietaryAndRestrictions,
        "medicalCondition": medicalCondition,
        "aboutChild": aboutChild,
        "isExpand": isExpand,
      };
}

class UserDetails {
  int? userId;
  String? name;
  String? image;
  double? rating;
  String? review;
  String? location;
  String? latitude;
  String? longitude;
  String? aboutMe;
  int? reviewCount;

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
      };
}
