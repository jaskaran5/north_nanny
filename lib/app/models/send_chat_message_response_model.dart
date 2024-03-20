// To parse this JSON data, do
//
//     final sendChatMessageResponseModel = sendChatMessageResponseModelFromJson(jsonString);

import 'dart:convert';

SendChatMessageResponseModel sendChatMessageResponseModelFromJson(String str) =>
    SendChatMessageResponseModel.fromJson(json.decode(str));

String sendChatMessageResponseModelToJson(SendChatMessageResponseModel data) =>
    json.encode(data.toJson());

class SendChatMessageResponseModel {
  int? response;
  dynamic message;
  SingleChatData? data;

  SendChatMessageResponseModel({
    this.response,
    this.message,
    this.data,
  });

  factory SendChatMessageResponseModel.fromJson(Map<String, dynamic> json) =>
      SendChatMessageResponseModel(
        response: json["response"],
        message: json["message"],
        data:
            json["data"] == null ? null : SingleChatData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "message": message,
        "data": data?.toJson(),
      };
}

class SingleChatData {
  String? senderName;
  String? messageDescription;
  DateTime? time;
  String? fileLink;
  bool? isFile;
  int? chatId;
  dynamic userId;
  String? toUserImage;
  int? toUserId;

  SingleChatData({
    this.senderName,
    this.messageDescription,
    this.time,
    this.fileLink,
    this.isFile,
    this.chatId,
    this.userId,
    this.toUserImage,
    this.toUserId,
  });

  factory SingleChatData.fromJson(Map<String, dynamic> json) => SingleChatData(
        senderName: json["senderName"],
        messageDescription: json["messageDescription"],
        time: json["time"] == null ? null : DateTime.parse(json["time"]),
        fileLink: json["fileLink"],
        isFile: json["isFile"],
        chatId: json["chatId"],
        userId: json["userId"],
        toUserImage: json["toUserImage"],
        toUserId: json["toUserId"],
      );

  Map<String, dynamic> toJson() => {
        "senderName": senderName,
        "messageDescription": messageDescription,
        "time": time?.toIso8601String(),
        "fileLink": fileLink,
        "isFile": isFile,
        "chatId": chatId,
        "userId": userId,
        "toUserImage": toUserImage,
        "toUserId": toUserId,
      };
}
