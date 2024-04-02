// To parse this JSON data, do
//
//     final filterRecentChatResponseModel = filterRecentChatResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:northshore_nanny_flutter/app/models/chat_list_response_model.dart';

FilterRecentChatResponseModel filterRecentChatResponseModelFromJson(
        String str) =>
    FilterRecentChatResponseModel.fromJson(json.decode(str));

String filterRecentChatResponseModelToJson(
        FilterRecentChatResponseModel data) =>
    json.encode(data.toJson());

class FilterRecentChatResponseModel {
  int? response;
  dynamic message;
  Data? data;

  FilterRecentChatResponseModel({
    this.response,
    this.message,
    this.data,
  });

  factory FilterRecentChatResponseModel.fromJson(Map<String, dynamic> json) =>
      FilterRecentChatResponseModel(
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

// class ChatList {
//   int? userId;
//   dynamic name;
//   String? image;
//   String? fileType;
//   DateTime? dateTime;
//   String? lastMessage;
//   bool? isOnline;
//   int? chatType;
//   bool? isBlock;
//   int? unreadMessageCount;
//   String? fullName;
//   bool? isLastMessageImage;
//   bool? isClearChat;

//   ChatList({
//     this.userId,
//     this.name,
//     this.image,
//     this.fileType,
//     this.dateTime,
//     this.lastMessage,
//     this.isOnline,
//     this.chatType,
//     this.isBlock,
//     this.unreadMessageCount,
//     this.fullName,
//     this.isLastMessageImage,
//     this.isClearChat,
//   });

//   factory ChatList.fromJson(Map<String, dynamic> json) => ChatList(
//         userId: json["userId"],
//         name: json["name"],
//         image: json["image"],
//         fileType: json["fileType"],
//         dateTime:
//             json["dateTime"] == null ? null : DateTime.parse(json["dateTime"]),
//         lastMessage: json["lastMessage"],
//         isOnline: json["isOnline"],
//         chatType: json["chatType"],
//         isBlock: json["isBlock"],
//         unreadMessageCount: json["unreadMessageCount"],
//         fullName: json["fullName"],
//         isLastMessageImage: json["isLastMessageImage"],
//         isClearChat: json["isClearChat"],
//       );

//   Map<String, dynamic> toJson() => {
//         "userId": userId,
//         "name": name,
//         "image": image,
//         "fileType": fileType,
//         "dateTime": dateTime?.toIso8601String(),
//         "lastMessage": lastMessage,
//         "isOnline": isOnline,
//         "chatType": chatType,
//         "isBlock": isBlock,
//         "unreadMessageCount": unreadMessageCount,
//         "fullName": fullName,
//         "isLastMessageImage": isLastMessageImage,
//         "isClearChat": isClearChat,
//       };
// }
