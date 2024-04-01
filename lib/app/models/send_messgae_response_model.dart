// To parse this JSON data, do
//
//     final sendMessageResponseModel = sendMessageResponseModelFromJson(jsonString);

import 'dart:convert';

SendMessageResponseModel sendMessageResponseModelFromJson(String str) =>
    SendMessageResponseModel.fromJson(json.decode(str));

String sendMessageResponseModelToJson(SendMessageResponseModel data) =>
    json.encode(data.toJson());

class SendMessageResponseModel {
  int? response;
  dynamic message;
  Data? data;

  SendMessageResponseModel({
    this.response,
    this.message,
    this.data,
  });

  factory SendMessageResponseModel.fromJson(Map<String, dynamic> json) =>
      SendMessageResponseModel(
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
  String? senderName;
  String? messageDescription;
  DateTime? time;
  String? fileLink;
  bool? isFile;
  int? chatId;
  dynamic userId;
  String? toUserImage;
  String? fileType;
  dynamic thumbImage;
  bool? isBlockChat;

  int? toUserId;

  Data({
    this.senderName,
    this.messageDescription,
    this.time,
    this.fileLink,
    this.isFile,
    this.chatId,
    this.userId,
    this.toUserImage,
    this.toUserId,
    this.fileType,
    this.thumbImage,
    this.isBlockChat,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        senderName: json["senderName"],
        messageDescription: json["messageDescription"],
        time: json["time"] == null ? null : DateTime.parse(json["time"]),
        fileLink: json["fileLink"],
        isFile: json["isFile"],
        chatId: json["chatId"],
        userId: json["userId"],
        toUserImage: json["toUserImage"],
        toUserId: json["toUserId"],
        fileType: json["fileType"],
        thumbImage: json["thumbImage"],
        isBlockChat: json["isBlockChat"],
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
        "fileType": fileType,
        "thumbImage": thumbImage,
        "isBlockChat": isBlockChat
      };
}
