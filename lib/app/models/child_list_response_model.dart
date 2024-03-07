// To parse this JSON data, do
//
//     final childListResponseModel = childListResponseModelFromJson(jsonString);

import 'dart:convert';

ChildListResponseModel childListResponseModelFromJson(String str) =>
    ChildListResponseModel.fromJson(json.decode(str));

String childListResponseModelToJson(ChildListResponseModel data) =>
    json.encode(data.toJson());

class ChildListResponseModel {
  int? response;
  dynamic message;
  List<ChildData>? data;

  ChildListResponseModel({
    this.response,
    this.message,
    this.data,
  });

  factory ChildListResponseModel.fromJson(Map<String, dynamic> json) =>
      ChildListResponseModel(
        response: json["response"],
        message: json["message"] ?? '',
        data: json["data"] == null
            ? []
            : List<ChildData>.from(
                json["data"]!.map((x) => ChildData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ChildData {
  int? childId;
  String? name;
  String? age;
  int? gender;
  String? allergiesDietaryAndRestrictions;
  String? medicalCondition;
  String? aboutChild;

  ChildData({
    this.childId,
    this.name,
    this.age,
    this.gender,
    this.allergiesDietaryAndRestrictions,
    this.medicalCondition,
    this.aboutChild,
  });

  factory ChildData.fromJson(Map<String, dynamic> json) => ChildData(
        childId: json["childId"] ?? '',
        name: json["name"] ?? "",
        age: json["age"] ?? "",
        gender: json["gender"] ?? "1",
        allergiesDietaryAndRestrictions:
            json["allergiesDietaryAndRestrictions"] ?? '',
        medicalCondition: json["medicalCondition"] ?? "",
        aboutChild: json["aboutChild"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "childId": childId,
        "name": name,
        "age": age,
        "gender": gender,
        "allergiesDietaryAndRestrictions": allergiesDietaryAndRestrictions,
        "medicalCondition": medicalCondition,
        "aboutChild": aboutChild,
      };
}
