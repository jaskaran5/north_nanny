// To parse this JSON data, do
//
//     final singleChatDataResponseModel = singleChatDataResponseModelFromJson(jsonString);

import 'dart:convert';

SingleChatDataResponseModel singleChatDataResponseModelFromJson(String str) =>
    SingleChatDataResponseModel.fromJson(json.decode(str));

String singleChatDataResponseModelToJson(SingleChatDataResponseModel data) =>
    json.encode(data.toJson());

class SingleChatDataResponseModel {
  int? response;
  dynamic message;
  SingleChatData? data;

  SingleChatDataResponseModel({
    this.response,
    this.message,
    this.data,
  });

  factory SingleChatDataResponseModel.fromJson(Map<String, dynamic> json) =>
      SingleChatDataResponseModel(
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
  List<MessageList>? messageList;
  bool? isBlock;
  int? blockBy;
  int? blockTo;

  SingleChatData({
    this.messageList,
    this.isBlock,
    this.blockBy,
    this.blockTo,
  });

  factory SingleChatData.fromJson(Map<String, dynamic> json) => SingleChatData(
        messageList: json["messageList"] == null
            ? []
            : List<MessageList>.from(
                json["messageList"]!.map((x) => MessageList.fromJson(x))),
        isBlock: json["isBlock"],
        blockBy: json["blockBy"],
        blockTo: json["blockTo"],
      );

  Map<String, dynamic> toJson() => {
        "messageList": messageList == null
            ? []
            : List<dynamic>.from(messageList!.map((x) => x.toJson())),
        "isBlock": isBlock,
        "blockBy": blockBy,
        "blockTo": blockTo,
      };
}

class MessageList {
  int? id;
  int? toUserId;
  int? fromUserId;
  String? message;
  DateTime? date;
  dynamic toUserImage;
  bool? isFile;
  dynamic fileLink;
  dynamic isChatDeleted;
  dynamic fileType;
  dynamic thumbImage;

  MessageList(
      {this.id,
      this.toUserId,
      this.fromUserId,
      this.message,
      this.date,
      this.toUserImage,
      this.isFile,
      this.fileLink,
      this.isChatDeleted,
      this.thumbImage,
      this.fileType});

  factory MessageList.fromJson(Map<String, dynamic> json) => MessageList(
      id: json["id"],
      toUserId: json["toUserId"],
      fromUserId: json["fromUserId"],
      message: json["message"],
      date: json["date"] == null ? null : DateTime.parse(json["date"]),
      toUserImage: json["toUserImage"],
      isFile: json["isFile"],
      fileLink: json["fileLink"],
      isChatDeleted: json["isChatDeleted"],
      fileType: json["fileType"],
      thumbImage: json["thumbImage"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "toUserId": toUserId,
        "fromUserId": fromUserId,
        "message": message,
        "date": date?.toIso8601String(),
        "toUserImage": toUserImage,
        "isFile": isFile,
        "fileLink": fileLink,
        "isChatDeleted": isChatDeleted,
        "fileType": fileType,
        "thumbImage": thumbImage
      };
}
