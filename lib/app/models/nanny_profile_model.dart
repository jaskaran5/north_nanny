
import 'dart:convert';

MyProfileModel myProfileModelFromJson(String str) => MyProfileModel.fromJson(json.decode(str));

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
  dynamic isDrivingLicence;
  List<dynamic>? ratingList;

  Data({
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
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
    services: json["services"] == null ? [] : List<String>.from(json["services"]!.map((x) => x)),
    age: json["age"],
    isDrivingLicence: json["isDrivingLicence"],
    ratingList: json["ratingList"] == null ? [] : List<dynamic>.from(json["ratingList"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
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
    "services": services == null ? [] : List<dynamic>.from(services!.map((x) => x)),
    "age": age,
    "isDrivingLicence": isDrivingLicence,
    "ratingList": ratingList == null ? [] : List<dynamic>.from(ratingList!.map((x) => x)),
  };
}
