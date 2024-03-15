import 'dart:convert';

BookingStatusModel bookingStatusModelFromJson(String str) =>
    BookingStatusModel.fromJson(json.decode(str));

String bookingStatusModelToJson(BookingStatusModel data) =>
    json.encode(data.toJson());

class BookingStatusModel {
  int? response;
  String? message;
  Data? data;

  BookingStatusModel({
    this.response,
    this.message,
    this.data,
  });

  factory BookingStatusModel.fromJson(Map<String, dynamic> json) =>
      BookingStatusModel(
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
  int? bookingStatus;

  Data({
    this.bookingStatus,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        bookingStatus: json["bookingStatus"],
      );

  Map<String, dynamic> toJson() => {
        "bookingStatus": bookingStatus,
      };
}
