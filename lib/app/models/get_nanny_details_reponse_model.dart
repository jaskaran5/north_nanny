// To parse this JSON data, do
//
//     final getNannyDetailsResponseModel = getNannyDetailsResponseModelFromJson(jsonString);

import 'dart:convert';

import 'nanny_profile_model.dart';

GetNannyDetailsResponseModel getNannyDetailsResponseModelFromJson(String str) =>
    GetNannyDetailsResponseModel.fromJson(json.decode(str));

String getNannyDetailsResponseModelToJson(GetNannyDetailsResponseModel data) =>
    json.encode(data.toJson());

class GetNannyDetailsResponseModel {
  int? response;
  dynamic message;
  GetNannyData? data;

  GetNannyDetailsResponseModel({
    this.response,
    this.message,
    this.data,
  });

  factory GetNannyDetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      GetNannyDetailsResponseModel(
        response: json["response"],
        message: json["message"],
        data: json["data"] == null ? null : GetNannyData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "message": message,
        "data": data?.toJson(),
      };
}

class GetNannyData {
  int? id;
  String? name;
  String? image;
  dynamic reviewCount;
  dynamic rating;
  String? experience;
  String? aboutMe;
  dynamic distance;
  dynamic age;
  dynamic gender;
  bool? isFavorite;
  bool? isOnline;
  bool? isCardAddedByCustomer;
  bool? isCustomerReferral;
  List<AvailabilityList>? availabilityList;
  List<RatingList>? ratingList;
  List<String>? services;

  GetNannyData({
    this.id,
    this.name,
    this.image,
    this.reviewCount,
    this.rating,
    this.experience,
    this.aboutMe,
    this.distance,
    this.services,
    this.isFavorite,
    this.availabilityList,
    this.age,
    this.gender,
    this.isOnline,
    this.isCardAddedByCustomer,
    this.ratingList,
    this.isCustomerReferral,
  });

  factory GetNannyData.fromJson(Map<String, dynamic> json) => GetNannyData(
        id: json["id"],
        name: json["name"] ?? '',
        image: json["image"] ?? "",
        reviewCount: json["reviewCount"] ?? '0',
        rating: json["rating"] ?? '',
        experience: json["experience"] ?? '',
        aboutMe: json["aboutMe"] ?? '',
        distance: json["distance"]?.toDouble(),
        isFavorite: json["isFavorite"],
        isOnline: json["isOnline"],
        isCardAddedByCustomer: json["isCardAddedByCustomer"] ?? false,
        isCustomerReferral: json["isCustomerRefferals"] ?? false,
        availabilityList: json["avilabilityList"] == null
            ? []
            : List<AvailabilityList>.from(json["avilabilityList"]!
                .map((x) => AvailabilityList.fromJson(x))),
        age: json["age"],
        gender: json["gender"],
        services: json["services"] == null
            ? []
            : List<String>.from(json["services"]!.map((x) => x)),
        ratingList: json["ratingList"] == null
            ? []
            : List<RatingList>.from(
                json["ratingList"]!.map((x) => RatingList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "reviewCount": reviewCount,
        "rating": rating,
        "experience": experience,
        "aboutMe": aboutMe,
        "distance": distance,
        "isOnline": isOnline,
        "isCardAddedByCustomer": isCardAddedByCustomer,
        "isCustomerRefferals": isCustomerReferral,
        "ratingList": ratingList == null
            ? []
            : List<dynamic>.from(ratingList!.map((x) => x.toJson())),
        "services":
            services == null ? [] : List<dynamic>.from(services!.map((x) => x)),
      };
}

class AvailabilityList {
  DateTime? openingTime;
  DateTime? closingTime;

  AvailabilityList({
    this.openingTime,
    this.closingTime,
  });

  factory AvailabilityList.fromJson(Map<String, dynamic> json) =>
      AvailabilityList(
        openingTime: json["openingTime"] == null
            ? null
            : DateTime.parse(json["openingTime"]),
        closingTime: json["closingTime"] == null
            ? null
            : DateTime.parse(json["closingTime"]),
      );

  Map<String, dynamic> toJson() => {
        "openingTime": openingTime?.toIso8601String(),
        "closingTime": closingTime?.toIso8601String(),
      };
}
