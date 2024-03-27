// To parse this JSON data, do
//
//     final chatListResponseModel = chatListResponseModelFromJson(jsonString);

import 'dart:convert';

ChatListResponseModel chatListResponseModelFromJson(String str) =>
    ChatListResponseModel.fromJson(json.decode(str));

String chatListResponseModelToJson(ChatListResponseModel data) =>
    json.encode(data.toJson());

class ChatListResponseModel {
  int? response;
  dynamic message;
  Data? data;

  ChatListResponseModel({
    this.response,
    this.message,
    this.data,
  });

  factory ChatListResponseModel.fromJson(Map<String, dynamic> json) =>
      ChatListResponseModel(
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
  List<ChatList>? chatList;

  Data({
    this.chatList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        chatList: json["chatList"] == null
            ? []
            : List<ChatList>.from(
                json["chatList"]!.map((x) => ChatList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "chatList": chatList == null
            ? []
            : List<dynamic>.from(chatList!.map((x) => x.toJson())),
      };
}

class ChatList {
  int? userId;
  dynamic name;
  String? image;
  DateTime? dateTime;
  String? lastMessage;
  bool? isOnline;
  int? chatType;
  bool? isBlock;
  int? unreadMessageCount;
  String? fullName;
  bool? isLastMessageImage;
  dynamic fileType;

  ChatList({
    this.userId,
    this.name,
    this.image,
    this.dateTime,
    this.lastMessage,
    this.isOnline,
    this.chatType,
    this.isBlock,
    this.unreadMessageCount,
    this.fullName,
    this.isLastMessageImage,
    this.fileType,
  });

  factory ChatList.fromJson(Map<String, dynamic> json) => ChatList(
        userId: json["userId"],
        name: json["name"],
        image: json["image"],
        dateTime:
            json["dateTime"] == null ? null : DateTime.parse(json["dateTime"]),
        lastMessage: json["lastMessage"],
        isOnline: json["isOnline"],
        chatType: json["chatType"],
        isBlock: json["isBlock"],
        unreadMessageCount: json["unreadMessageCount"],
        fullName: json["fullName"],
        fileType: json["fileType"],
        isLastMessageImage: json["isLastMessageImage"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "name": name,
        "image": image,
        "dateTime": dateTime?.toIso8601String(),
        "lastMessage": lastMessage,
        "isOnline": isOnline,
        "chatType": chatType,
        "isBlock": isBlock,
        "unreadMessageCount": unreadMessageCount,
        "fullName": fullName,
        "isLastMessageImage": isLastMessageImage,
        "fileType": fileType
      };
}
