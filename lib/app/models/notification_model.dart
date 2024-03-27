import 'dart:convert';

NotificationEntityModel notificationEntityModelFromJson(String str) =>
    NotificationEntityModel.fromJson(json.decode(str));

String notificationEntityModelToJson(NotificationEntityModel data) =>
    json.encode(data.toJson());

class NotificationEntityModel {
  dynamic datetime;
  dynamic bookingStatus;
  dynamic notificationType;
  dynamic notificationId;
  dynamic body;
  dynamic title;
  dynamic bookingId;

  NotificationEntityModel({
    this.datetime,
    this.bookingStatus,
    this.notificationType,
    this.notificationId,
    this.body,
    this.title,
    this.bookingId,
  });

  factory NotificationEntityModel.fromJson(Map<String, dynamic> json) =>
      NotificationEntityModel(
        datetime: json["datetime"],
        bookingStatus: json["bookingstatus"],
        notificationType: json["notificationtype"],
        notificationId: json["notificationid"],
        body: json["body"],
        title: json["title"],
        bookingId: json["bookingid"],
      );

  Map<String, dynamic> toJson() => {
        "datetime": datetime,
        "bookingstatus": bookingStatus,
        "notificationtype": notificationType,
        "notificationid": notificationId,
        "body": body,
        "title": title,
        "bookingid": bookingId,
      };
}
