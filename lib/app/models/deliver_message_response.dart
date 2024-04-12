import 'dart:convert';

DeliverMessageResponse deliverMessageResponseFromJson(String str) =>
    DeliverMessageResponse.fromJson(json.decode(str));

String deliverMessageResponseToJson(DeliverMessageResponse data) =>
    json.encode(data.toJson());

class DeliverMessageResponse {
  int? response;
  dynamic message;
  Data? data;

  DeliverMessageResponse({
    this.response,
    this.message,
    this.data,
  });

  factory DeliverMessageResponse.fromJson(Map<String, dynamic> json) =>
      DeliverMessageResponse(
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
  int? chatId;
  DateTime? date;

  Data({
    this.chatId,
    this.date,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        chatId: json["chatId"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "chatId": chatId,
        "date": date?.toIso8601String(),
      };
}
