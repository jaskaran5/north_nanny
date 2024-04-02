import 'dart:convert';

NotificationEntityModel notificationEntityModelFromJson(String str) =>
    NotificationEntityModel.fromJson(json.decode(str));

String notificationEntityModelToJson(NotificationEntityModel data) =>
    json.encode(data.toJson());

class NotificationEntityModel {
  String? datetime;
  String? bookingStatus;
  String? notificationType;
  String? notificationId;
  String? body;
  String? title;
  String? bookingId;
  dynamic type;
  dynamic receiverId;
  dynamic senderId;

  dynamic senderImage;
  dynamic senderName;

  NotificationEntityModel({
    this.datetime,
    this.bookingStatus,
    this.notificationType,
    this.notificationId,
    this.body,
    this.title,
    this.bookingId,
    this.type,
    this.receiverId,
    this.senderId,
    this.senderImage,
    this.senderName,
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
        type: json["Type"],
        senderId: json["SenderId"],
        senderImage: json["SenderImage"],
        senderName: json["SenderName"],
        receiverId: json["ReciverId"],
      );

  Map<String, dynamic> toJson() => {
        "datetime": datetime,
        "bookingstatus": bookingStatus,
        "notificationtype": notificationType,
        "notificationid": notificationId,
        "body": body,
        "title": title,
        "bookingid": bookingId,
        "type": type,
        "reciverId": receiverId,
        "senderImage": senderImage,
        "senderId": senderId,
      };
}
