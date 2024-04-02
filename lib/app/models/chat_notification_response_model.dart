// To parse this JSON data, do
//
//     final chatNotificationResponseModel = chatNotificationResponseModelFromJson(jsonString);

import 'dart:convert';

ChatNotificationResponseModel chatNotificationResponseModelFromJson(
        String str) =>
    ChatNotificationResponseModel.fromJson(json.decode(str));

String chatNotificationResponseModelToJson(
        ChatNotificationResponseModel data) =>
    json.encode(data.toJson());

class ChatNotificationResponseModel {
  int? type;
  int? reciverId;
  String? senderImage;
  String? senderName;
  String? body;
  String? title;
  int? senderId;

  ChatNotificationResponseModel({
    this.type,
    this.reciverId,
    this.senderImage,
    this.senderName,
    this.body,
    this.title,
    this.senderId,
  });

  factory ChatNotificationResponseModel.fromJson(Map<String, dynamic> json) =>
      ChatNotificationResponseModel(
        type: json["Type"],
        reciverId: json["ReciverId"],
        senderImage: json["SenderImage"],
        senderName: json["SenderName"],
        body: json["body"],
        title: json["title"],
        senderId: json["SenderId"],
      );

  Map<String, dynamic> toJson() => {
        "Type": type,
        "ReciverId": reciverId,
        "SenderImage": senderImage,
        "SenderName": senderName,
        "body": body,
        "title": title,
        "SenderId": senderId,
      };
}
