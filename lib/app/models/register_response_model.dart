// To parse this JSON data, do
//
//     final registerModelResponseJson = registerModelResponseJsonFromJson(jsonString);

import 'dart:convert';

RegisterModelResponseJson registerModelResponseJsonFromJson(String str) =>
    RegisterModelResponseJson.fromJson(json.decode(str));

String registerModelResponseJsonToJson(RegisterModelResponseJson data) =>
    json.encode(data.toJson());

class RegisterModelResponseJson {
  int? response;
  dynamic error;
  String? message;
  Data? data;

  RegisterModelResponseJson({
    this.response,
    this.error,
    this.message,
    this.data,
  });

  factory RegisterModelResponseJson.fromJson(Map<String, dynamic> json) =>
      RegisterModelResponseJson(
        response: json["response"],
        error: json["error"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "error": error,
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
  dynamic firstName;
  dynamic lastName;
  String? email;
  dynamic mobileNumber;
  dynamic dob;
  dynamic gender;
  dynamic image;
  dynamic aboutMe;
  dynamic authorizationId;
  dynamic mode;
  String? deviceToken;
  String? deviceType;
  dynamic userName;
  dynamic location;
  dynamic latitude;
  dynamic longitude;
  dynamic isOnline;
  dynamic connectionId;
  bool? isProfileCreated;
  dynamic address;
  dynamic isAccountDeleted;
  dynamic timeZone;
  int? userType;
  String? encryptedKey;
  dynamic age;
  dynamic experience;
  dynamic isDrivingLicense;

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
      };
}
