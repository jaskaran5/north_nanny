import 'dart:convert';

ClearChatResponseModel sendMessageResponseModelFromJson(String str) =>
    ClearChatResponseModel.fromJson(json.decode(str));

String clearChatResponseModelToJson(ClearChatResponseModel data) =>
    json.encode(data.toJson());

class ClearChatResponseModel {
  int? response;
  dynamic message;
  dynamic data;

  ClearChatResponseModel({
    this.response,
    this.message,
    this.data,
  });

  factory ClearChatResponseModel.fromJson(Map<String, dynamic> json) =>
      ClearChatResponseModel(
        response: json["response"],
        message: json["message"],
        data: json["data"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "message": message,
        "data": data?.toJson(),
      };
}
