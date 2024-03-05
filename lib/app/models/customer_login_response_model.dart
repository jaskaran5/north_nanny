// To parse this JSON data, do
//
//     final customerLoginResponseModel = customerLoginResponseModelFromJson(jsonString);

import 'dart:convert';

CustomerLoginResponseModel customerLoginResponseModelFromJson(String str) =>
    CustomerLoginResponseModel.fromJson(json.decode(str));

String customerLoginResponseModelToJson(CustomerLoginResponseModel data) =>
    json.encode(data.toJson());

class CustomerLoginResponseModel {
  int? response;
  String? message;
  Data? data;

  CustomerLoginResponseModel({
    this.response,
    this.message,
    this.data,
  });

  factory CustomerLoginResponseModel.fromJson(Map<String, dynamic> json) =>
      CustomerLoginResponseModel(
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
  User? user;
  String? token;

  Data({
    this.user,
    this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "token": token,
      };
}

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  dynamic mobileNumber;
  dynamic dob;
  int? gender;
  String? image;
  dynamic aboutMe;
  dynamic authorizationId;
  dynamic mode;
  String? deviceToken;
  String? deviceType;
  dynamic userName;
  dynamic location;
  String? latitude;
  dynamic longitude;
  dynamic isOnline;
  dynamic connectionId;
  bool? isProfileCreated;
  String? address;
  dynamic isAccountDeleted;
  dynamic timeZone;
  int? userType;
  String? encryptedKey;
  dynamic age;
  dynamic experience;
  dynamic isDrivingLicense;
  bool? isAproved;
  bool? isServicesCreated;
  bool? isBankDetailAdded;
  bool? isAvailable;
  dynamic isSkipBankDetail;
  bool? isChildAdded;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.mobileNumber,
    this.dob,
    this.gender,
    this.image,
    this.aboutMe,
    this.authorizationId,
    this.mode,
    this.deviceToken,
    this.deviceType,
    this.userName,
    this.location,
    this.latitude,
    this.longitude,
    this.isOnline,
    this.connectionId,
    this.isProfileCreated,
    this.address,
    this.isAccountDeleted,
    this.timeZone,
    this.userType,
    this.encryptedKey,
    this.age,
    this.experience,
    this.isDrivingLicense,
    this.isAproved,
    this.isServicesCreated,
    this.isBankDetailAdded,
    this.isAvailable,
    this.isSkipBankDetail,
    this.isChildAdded,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        mobileNumber: json["mobileNumber"],
        dob: json["dob"],
        gender: json["gender"],
        image: json["image"],
        aboutMe: json["aboutMe"],
        authorizationId: json["authorizationId"],
        mode: json["mode"],
        deviceToken: json["deviceToken"],
        deviceType: json["deviceType"],
        userName: json["userName"],
        location: json["location"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        isOnline: json["isOnline"],
        connectionId: json["connectionId"],
        isProfileCreated: json["isProfileCreated"],
        address: json["address"],
        isAccountDeleted: json["isAccountDeleted"],
        timeZone: json["timeZone"],
        userType: json["userType"],
        encryptedKey: json["encryptedKey"],
        age: json["age"],
        experience: json["experience"],
        isDrivingLicense: json["isDrivingLicense"],
        isAproved: json["isAproved"],
        isServicesCreated: json["isServicesCreated"],
        isBankDetailAdded: json["isBankDetailAdded"],
        isAvailable: json["isAvailable"],
        isSkipBankDetail: json["isSkipBankDetail"],
        isChildAdded: json["isChildAdded"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "mobileNumber": mobileNumber,
        "dob": dob,
        "gender": gender,
        "image": image,
        "aboutMe": aboutMe,
        "authorizationId": authorizationId,
        "mode": mode,
        "deviceToken": deviceToken,
        "deviceType": deviceType,
        "userName": userName,
        "location": location,
        "latitude": latitude,
        "longitude": longitude,
        "isOnline": isOnline,
        "connectionId": connectionId,
        "isProfileCreated": isProfileCreated,
        "address": address,
        "isAccountDeleted": isAccountDeleted,
        "timeZone": timeZone,
        "userType": userType,
        "encryptedKey": encryptedKey,
        "age": age,
        "experience": experience,
        "isDrivingLicense": isDrivingLicense,
        "isAproved": isAproved,
        "isServicesCreated": isServicesCreated,
        "isBankDetailAdded": isBankDetailAdded,
        "isAvailable": isAvailable,
        "isSkipBankDetail": isSkipBankDetail,
        "isChildAdded": isChildAdded,
      };
}
