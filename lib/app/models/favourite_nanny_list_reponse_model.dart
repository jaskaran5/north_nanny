// To parse this JSON data, do
//
//     final favouriteListResponseModel = favouriteListResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:northshore_nanny_flutter/app/models/nanny_profile_model.dart';

favouriteListResponseModelFromJson(String str) =>
    FavouriteListResponseModel.fromJson(json.decode(str));

String favouriteListResponseModelToJson(FavouriteListResponseModel data) =>
    json.encode(data.toJson());

class FavouriteListResponseModel {
  int? response;
  dynamic message;
  List<FavouriteNanny>? data;

  FavouriteListResponseModel({
    this.response,
    this.message,
    this.data,
  });

  factory FavouriteListResponseModel.fromJson(Map<String, dynamic> json) =>
      FavouriteListResponseModel(
        response: json["response"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<FavouriteNanny>.from(
                json["data"]!.map((x) => FavouriteNanny.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class FavouriteNanny {
  dynamic id;
  int? nannyId;
  dynamic gender;
  dynamic name;
  dynamic image;
  dynamic isFavorite;
  dynamic aboutMe;
  dynamic distance;
  dynamic age;
  dynamic experience;
  dynamic location;
  dynamic latitude;
  dynamic longitude;
  dynamic reviewCount;
  dynamic rating;
  List<RatingList>? ratingList;

  FavouriteNanny(
      {this.id,
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
      this.nannyId});

  factory FavouriteNanny.fromJson(Map<String, dynamic> json) => FavouriteNanny(
        id: json["id"],
        nannyId: json["nannyId"],
        gender: json["gender"] ?? 0,
        name: json["name"] ?? '',
        image: json["image"] ?? '',
        isFavorite: json["isFavorite"] ?? false,
        aboutMe: json["aboutMe"] ?? '',
        distance: json["distance"]?.toDouble(),
        age: json["age"] ?? '',
        experience: json["experience"] ?? '',
        location: json["location"] ?? '',
        latitude: json["latitude"] ?? '',
        longitude: json["longitude"] ?? '',
        reviewCount: json["reviewCount"] ?? 0,
        rating: json["rating"] ?? 0.0,
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
        "nannyId": nannyId,
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
