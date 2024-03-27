

import 'dart:convert';

NotificationListModel notificationEntityModelFromJson(String str) => NotificationListModel.fromJson(json.decode(str));

String notificationEntityModelToJson(NotificationListModel data) => json.encode(data.toJson());

class NotificationListModel {
  int? response;
  dynamic message;
  List<NotificationData>? data;

  NotificationListModel({
    this.response,
    this.message,
    this.data,
  });

  factory NotificationListModel.fromJson(Map<String, dynamic> json) => NotificationListModel(
    response: json["response"],
    message: json["message"],
    data: json["data"] == null ? [] : List<NotificationData>.from(json["data"]!.map((x) => NotificationData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class NotificationData {
  int? notificationId;
  int? senderId;
  String? title;
  String? description;
  DateTime? createdOn;
  dynamic notificationType;
  bool? isRead;
  dynamic bookingStatus;
  dynamic bookingId;

  NotificationData({
    this.notificationId,
    this.senderId,
    this.title,
    this.description,
    this.createdOn,
    this.notificationType,
    this.isRead,
    this.bookingStatus,
    this.bookingId,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) => NotificationData(
    notificationId: json["notificationId"],
    senderId: json["senderId"],
    title: json["title"],
    description: json["description"],
    createdOn: json["createdOn"] == null ? null : DateTime.parse(json["createdOn"]),
    notificationType: json["notificationType"],
    isRead: json["isRead"],
    bookingStatus: json["bookingStatus"],
    bookingId: json["bookingId"],
  );

  Map<String, dynamic> toJson() => {
    "notificationId": notificationId,
    "senderId": senderId,
    "title": title,
    "description": description,
    "createdOn": createdOn?.toIso8601String(),
    "notificationType": notificationType,
    "isRead": isRead,
    "bookingStatus": bookingStatus,
    "bookingId": bookingId,
  };
}
