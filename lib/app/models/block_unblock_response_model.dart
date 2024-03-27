// To parse this JSON data, do
//
//     final blockUnBlockResponseModel = blockUnBlockResponseModelFromJson(jsonString);

import 'dart:convert';

BlockUnBlockResponseModel blockUnBlockResponseModelFromJson(String str) =>
    BlockUnBlockResponseModel.fromJson(json.decode(str));

String blockUnBlockResponseModelToJson(BlockUnBlockResponseModel data) =>
    json.encode(data.toJson());

class BlockUnBlockResponseModel {
  int? response;
  dynamic message;
  Data? data;

  BlockUnBlockResponseModel({
    this.response,
    this.message,
    this.data,
  });

  factory BlockUnBlockResponseModel.fromJson(Map<String, dynamic> json) =>
      BlockUnBlockResponseModel(
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
  bool? isBlock;

  Data({
    this.isBlock,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        isBlock: json["isBlock"],
      );

  Map<String, dynamic> toJson() => {
        "isBlock": isBlock,
      };
}
