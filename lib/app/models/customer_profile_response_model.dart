// To parse this JSON data, do
//
//     final customerProfileResponseModel = customerProfileResponseModelFromJson(jsonString);

import 'dart:convert';

CustomerProfileResponseModel customerProfileResponseModelFromJson(String str) =>
    CustomerProfileResponseModel.fromJson(json.decode(str));

String customerProfileResponseModelToJson(CustomerProfileResponseModel data) =>
    json.encode(data.toJson());

class CustomerProfileResponseModel {
  int? response;
  dynamic message;
  CustomerProfileData? customerProfileData;

  CustomerProfileResponseModel({
    this.response,
    this.message,
    this.customerProfileData,
  });

  factory CustomerProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      CustomerProfileResponseModel(
        response: json["response"],
        message: json["message"],
        customerProfileData: json["data"] == null
            ? null
            : CustomerProfileData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "message": message,
        "data": customerProfileData?.toJson(),
      };
}

class CustomerProfileData {
  String? firstName;
  String? lastName;
  String? email;
  int? userId;
  dynamic location;
  dynamic mobileNo;
  dynamic referralsEarned;
  String? image;

  CustomerProfileData({
    this.firstName,
    this.lastName,
    this.email,
    this.userId,
    this.location,
    this.mobileNo,
    this.referralsEarned,
    this.image,
  });

  factory CustomerProfileData.fromJson(Map<String, dynamic> json) =>
      CustomerProfileData(
        firstName: json["firstName"] ?? "",
        lastName: json["lastName"] ?? '',
        email: json["email"] ?? "",
        userId: json["userId"] ?? '',
        location: json["location"] ?? "",
        mobileNo: json["mobileNo"] ?? '',
        referralsEarned: json["referralsEarned"] ?? '0',
        image: json["image"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "userId": userId,
        "location": location,
        "mobileNo": mobileNo,
        "referralsEarned": referralsEarned,
        "image": image,
      };
}
