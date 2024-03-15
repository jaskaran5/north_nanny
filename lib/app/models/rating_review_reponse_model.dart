// To parse this JSON data, do
//
//     final ratingReviewResponseModel = ratingReviewResponseModelFromJson(jsonString);

import 'dart:convert';

RatingReviewResponseModel ratingReviewResponseModelFromJson(String str) =>
    RatingReviewResponseModel.fromJson(json.decode(str));

String ratingReviewResponseModelToJson(RatingReviewResponseModel data) =>
    json.encode(data.toJson());

class RatingReviewResponseModel {
  int? response;
  dynamic message;
  Data? data;

  RatingReviewResponseModel({
    this.response,
    this.message,
    this.data,
  });

  factory RatingReviewResponseModel.fromJson(Map<String, dynamic> json) =>
      RatingReviewResponseModel(
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
  int? reviewCount;
  int? rating;
  List<RatingList>? ratingList;

  Data({
    this.reviewCount,
    this.rating,
    this.ratingList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        reviewCount: json["reviewCount"],
        rating: json["rating"],
        ratingList: json["ratingList"] == null
            ? []
            : List<RatingList>.from(json["ratingList"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "reviewCount": reviewCount,
        "rating": rating,
        "ratingList": ratingList == null
            ? []
            : List<RatingList>.from(ratingList!.map((x) => x)),
      };
}

class RatingList {
  String? name;
  String? image;
  String? review;
  DateTime? datetime;
  double? rating;

  RatingList({
    this.name,
    this.image,
    this.review,
    this.datetime,
    this.rating,
  });

  factory RatingList.fromJson(Map<String, dynamic> json) => RatingList(
        name: json["name"],
        image: json["image"],
        review: json["review"],
        datetime:
            json["datetime"] == null ? null : DateTime.parse(json["datetime"]),
        rating: json["rating"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
        "review": review,
        "datetime": datetime?.toIso8601String(),
        "rating": rating,
      };
}
