// To parse this JSON data, do
//
//     final bookingDataByIdResponseModel = bookingDataByIdResponseModelFromJson(jsonString);

import 'dart:convert';

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
  dynamic bookingId;
  dynamic hourlyprice;
  int? userId;
  String? location;
  String? latitude;
  String? longitude;
  DateTime? bookingDate;
  DateTime? openingDate;
  DateTime? closingDate;
  dynamic startTime;
  List<String>? servicesType;
  List<Child>? children;
  UserDetails? userDetails;
  int? totalChildern;
  int? totalHour;
  double? totalAmount;
  dynamic userReviewList;

  BookingDataById({
    this.bookingId,
    this.hourlyprice,
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
    this.totalChildern,
    this.totalHour,
    this.totalAmount,
    this.userReviewList,
  });

  factory BookingDataById.fromJson(Map<String, dynamic> json) =>
      BookingDataById(
        bookingId: json["bookingId"],
        hourlyprice: json["hourlyprice"],
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
        startTime: json["startTime"],
        servicesType: json["servicesType"] == null
            ? []
            : List<String>.from(json["servicesType"]!.map((x) => x)),
        children: json["children"] == null
            ? []
            : List<Child>.from(json["children"]!.map((x) => Child.fromJson(x))),
        userDetails: json["userDetails"] == null
            ? null
            : UserDetails.fromJson(json["userDetails"]),
        totalChildern: json["totalChildern"],
        totalHour: json["totalHour"],
        totalAmount: json["totalAmount"]?.toDouble(),
        userReviewList: json["userReviewList"],
      );

  Map<String, dynamic> toJson() => {
        "bookingId": bookingId,
        "hourlyprice": hourlyprice,
        "userId": userId,
        "location": location,
        "latitude": latitude,
        "longitude": longitude,
        "bookingDate": bookingDate?.toIso8601String(),
        "openingDate": openingDate?.toIso8601String(),
        "closingDate": closingDate?.toIso8601String(),
        "startTime": startTime,
        "servicesType": servicesType == null
            ? []
            : List<dynamic>.from(servicesType!.map((x) => x)),
        "children": children == null
            ? []
            : List<dynamic>.from(children!.map((x) => x.toJson())),
        "userDetails": userDetails?.toJson(),
        "totalChildern": totalChildern,
        "totalHour": totalHour,
        "totalAmount": totalAmount,
        "userReviewList": userReviewList,
      };
}

class Child {
  String? name;
  String? age;
  int? gender;
  String? allergiesDietaryAndRestrictions;
  String? medicalCondition;
  String? aboutChild;

  Child({
    this.name,
    this.age,
    this.gender,
    this.allergiesDietaryAndRestrictions,
    this.medicalCondition,
    this.aboutChild,
  });

  factory Child.fromJson(Map<String, dynamic> json) => Child(
        name: json["name"],
        age: json["age"],
        gender: json["gender"],
        allergiesDietaryAndRestrictions:
            json["allergiesDietaryAndRestrictions"],
        medicalCondition: json["medicalCondition"],
        aboutChild: json["aboutChild"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "age": age,
        "gender": gender,
        "allergiesDietaryAndRestrictions": allergiesDietaryAndRestrictions,
        "medicalCondition": medicalCondition,
        "aboutChild": aboutChild,
      };
}

class UserDetails {
  int? userId;
  String? name;
  String? image;
  int? rating;
  dynamic review;
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
