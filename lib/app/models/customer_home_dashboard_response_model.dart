// To parse this JSON data, do
//
//     final customerHomeDashboardResponseModel = customerHomeDashboardResponseModelFromJson(jsonString);

import 'dart:convert';

import 'nanny_profile_model.dart';

CustomerHomeDashboardResponseModel customerHomeDashboardResponseModelFromJson(
        String str) =>
    CustomerHomeDashboardResponseModel.fromJson(json.decode(str));

String customerHomeDashboardResponseModelToJson(
        CustomerHomeDashboardResponseModel data) =>
    json.encode(data.toJson());

class CustomerHomeDashboardResponseModel {
  int? response;
  dynamic message;
  List<NannyDataList>? data;

  CustomerHomeDashboardResponseModel({
    this.response,
    this.message,
    this.data,
  });

  factory CustomerHomeDashboardResponseModel.fromJson(
          Map<String, dynamic> json) =>
      CustomerHomeDashboardResponseModel(
        response: json["response"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<NannyDataList>.from(
                json["data"]!.map((x) => NannyDataList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class NannyDataList {
  int? id;
  dynamic gender;
  dynamic name;
  dynamic image;
  bool? isFavorite;
  dynamic aboutMe;
  double? distance;
  dynamic age;
  dynamic experience;
  dynamic location;
  dynamic latitude;
  dynamic longitude;
  dynamic reviewCount;
  dynamic rating;
  List<RatingList>? ratingList;

  NannyDataList({
    this.id,
    this.gender,
    this.name,
    this.image,
    this.isFavorite,
    this.aboutMe,
    this.distance,
    this.age,
    this.experience,
    this.location,
    this.latitude,
    this.longitude,
    this.reviewCount,
    this.rating,
    this.ratingList,
  });

  factory NannyDataList.fromJson(Map<String, dynamic> json) => NannyDataList(
        id: json["id"] ?? '',
        gender: json["gender"] ?? '',
        name: json["name"] ?? '',
        image: json["image"] ?? '',
        isFavorite: json["isFavorite"] ?? '',
        aboutMe: json["aboutMe"] ?? '',
        distance: json["distance"]?.toDouble(),
        age: json["age"] ?? '',
        experience: json["experience"] ?? '',
        location: json["location"] ?? "",
        latitude: json["latitude"] ?? '',
        longitude: json["longitude"] ?? '',
        reviewCount: json["reviewCount"] ?? '',
        rating: json["rating"] ?? '',
        ratingList: json["ratingList"] == null
            ? []
            : List<RatingList>.from(
                json["ratingList"]!.map((x) => RatingList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "gender": gender,
        "name": name,
        "image": image,
        "isFavorite": isFavorite,
        "aboutMe": aboutMe,
        "distance": distance,
        "age": age,
        "experience": experience,
        "location": location,
        "latitude": latitude,
        "longitude": longitude,
        "reviewCount": reviewCount,
        "rating": rating,
        "ratingList": ratingList == null
            ? []
            : List<dynamic>.from(ratingList!.map((x) => x.toJson())),
      };
}
