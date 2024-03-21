import 'dart:convert';

TrackerLocationModel trackerLocationModelFromJson(String str) =>
    TrackerLocationModel.fromJson(json.decode(str));

String trackerLocationModelToJson(TrackerLocationModel data) =>
    json.encode(data.toJson());

class TrackerLocationModel {
  int? response;
  String? message;
  Data? data;

  TrackerLocationModel({
    this.response,
    this.message,
    this.data,
  });

  factory TrackerLocationModel.fromJson(Map<String, dynamic> json) =>
      TrackerLocationModel(
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
  int? bookingId;
  String? latitude;
  String? longitude;

  Data({
    this.bookingId,
    this.latitude,
    this.longitude,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        bookingId: json["bookingId"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "bookingId": bookingId,
        "latitude": latitude,
        "longitude": longitude,
      };
}
