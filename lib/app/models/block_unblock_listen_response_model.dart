// To parse this JSON data, do
//
//     final blockUnblockListenResponseModel = blockUnblockListenResponseModelFromJson(jsonString);

import 'dart:convert';

BlockUnblockListenResponseModel blockUnblockListenResponseModelFromJson(
        String str) =>
    BlockUnblockListenResponseModel.fromJson(json.decode(str));

String blockUnblockListenResponseModelToJson(
        BlockUnblockListenResponseModel data) =>
    json.encode(data.toJson());

class BlockUnblockListenResponseModel {
  int? response;
  dynamic message;
  Data? data;

  BlockUnblockListenResponseModel({
    this.response,
    this.message,
    this.data,
  });

  factory BlockUnblockListenResponseModel.fromJson(Map<String, dynamic> json) =>
      BlockUnblockListenResponseModel(
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
  int? blockedBy;
  int? blockedTo;
  int? unBlockedBy;
  int? unBlockedTo;
  bool? isBlock;

  Data({
    this.blockedBy,
    this.blockedTo,
    this.unBlockedBy,
    this.unBlockedTo,
    this.isBlock,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        blockedBy: json["blockedBy"],
        blockedTo: json["blockedTo"],
        unBlockedBy: json["unBlockedBy"],
        unBlockedTo: json["unBlockedTo"],
        isBlock: json["isBlock"],
      );

  Map<String, dynamic> toJson() => {
        "blockedBy": blockedBy,
        "blockedTo": blockedTo,
        "unBlockedBy": unBlockedBy,
        "unBlockedTo": unBlockedTo,
        "isBlock": isBlock,
      };
}
