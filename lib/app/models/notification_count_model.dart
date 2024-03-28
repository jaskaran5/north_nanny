import 'dart:convert';

NotificationCountModel notificationCountModelFromJson(String str) =>
    NotificationCountModel.fromJson(json.decode(str));

String notificationCountModelToJson(NotificationCountModel data) =>
    json.encode(data.toJson());

class NotificationCountModel {
  int? response;
  dynamic message;
  int? data;

  NotificationCountModel({
    this.response,
    this.message,
    this.data,
  });

  factory NotificationCountModel.fromJson(Map<String, dynamic> json) =>
      NotificationCountModel(
        response: json["response"],
        message: json["message"] ?? '',
        data: json["data"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "message": message,
        "data": data,
      };
}
