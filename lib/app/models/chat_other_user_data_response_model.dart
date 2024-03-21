// To parse this JSON data, do
//
//     final chatOtherUserData = chatOtherUserDataFromJson(jsonString);

import 'dart:convert';

ChatOtherUserData chatOtherUserDataFromJson(String str) =>
    ChatOtherUserData.fromJson(json.decode(str));

String chatOtherUserDataToJson(ChatOtherUserData data) =>
    json.encode(data.toJson());

class ChatOtherUserData {
  UserData? data;

  ChatOtherUserData({
    this.data,
  });

  factory ChatOtherUserData.fromJson(Map<String, dynamic> json) =>
      ChatOtherUserData(
        data: json["data"] == null ? null : UserData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class UserData {
  String? name;
  dynamic isOnline;
  String? image;

  UserData({
    this.name,
    this.isOnline,
    this.image,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        name: json["name"],
        isOnline: json["isOnline"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "isOnline": isOnline,
        "image": image,
      };
}
