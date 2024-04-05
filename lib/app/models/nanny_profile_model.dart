import 'dart:convert';

MyProfileModel myProfileModelFromJson(String str) =>
    MyProfileModel.fromJson(json.decode(str));

String myProfileModelToJson(MyProfileModel data) => json.encode(data.toJson());

class MyProfileModel {
  int? response;
  dynamic message;
  Data? data;

  MyProfileModel({
    this.response,
    this.message,
    this.data,
  });

  factory MyProfileModel.fromJson(Map<String, dynamic> json) => MyProfileModel(
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
  String? firstName;
  String? lastName;
  String? email;
  int? userId;
  String? name;
  String? image;
  int? gender;
  int? reviewCount;
  double? rating;
  String? experience;
  String? about;
  String? highSchool;
  String? college;
  String? location;
  String? mobileNo;
  dynamic bonusReferrals;
  List<String>? services;
  int? age;
  DateTime? dob;
  dynamic isDrivingLicence;
  List<RatingList>? ratingList;

  Data({
    this.firstName,
    this.lastName,
    this.email,
    this.userId,
    this.name,
    this.image,
    this.gender,
    this.reviewCount,
    this.rating,
    this.experience,
    this.about,
    this.highSchool,
    this.college,
    this.location,
    this.mobileNo,
    this.bonusReferrals,
    this.services,
    this.age,
    this.isDrivingLicence,
    this.ratingList,
    this.dob,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        userId: json["userId"],
        name: json["name"],
        image: json["image"],
        gender: json["gender"],
        reviewCount: json["reviewCount"],
        rating: json["rating"],
        experience: json["experience"],
        about: json["about"],
        highSchool: json["highSchool"],
        college: json["college"],
        location: json["location"],
        mobileNo: json["mobileNo"],
        bonusReferrals: json["bonusReferrals"],
        services: json["services"] == null
            ? []
            : List<String>.from(json["services"]!.map((x) => x)),
        age: json["age"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        isDrivingLicence: json["isDrivingLicence"],
        ratingList: json["ratingList"] == null
            ? []
            : List<RatingList>.from(
                json["ratingList"]!.map((x) => RatingList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "userId": userId,
        "name": name,
        "image": image,
        "gender": gender,
        "reviewCount": reviewCount,
        "rating": rating,
        "experience": experience,
        "about": about,
        "highSchool": highSchool,
        "college": college,
        "location": location,
        "mobileNo": mobileNo,
        "bonusReferrals": bonusReferrals,
        "services":
            services == null ? [] : List<dynamic>.from(services!.map((x) => x)),
        "age": age,
        "isDrivingLicence": isDrivingLicence,
        "ratingList": ratingList == null
            ? []
            : List<dynamic>.from(ratingList!.map((x) => x.toJson())),
        "dob": dob?.toIso8601String(),
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
