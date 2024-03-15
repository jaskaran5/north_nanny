import 'dart:convert';

NannyDataByBookingSlots nannyDataByBookingSlotsFromJson(String str) =>
    NannyDataByBookingSlots.fromJson(json.decode(str));

String nannyDataByBookingSlotsToJson(NannyDataByBookingSlots data) =>
    json.encode(data.toJson());

class NannyDataByBookingSlots {
  int? response;
  String? message;
  Data? data;

  NannyDataByBookingSlots({
    this.response,
    this.message,
    this.data,
  });

  factory NannyDataByBookingSlots.fromJson(Map<String, dynamic> json) =>
      NannyDataByBookingSlots(
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
  Book? bookingDetail;
  List<Book>? bookedSlot;

  Data({
    this.bookingDetail,
    this.bookedSlot,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        bookingDetail: json["bookingdetail"] == null
            ? null
            : Book.fromJson(json["bookingdetail"]),
        bookedSlot: json["bookedSlot"] == null
            ? []
            : List<Book>.from(json["bookedSlot"]!.map((x) => Book.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "bookingdetail": bookingDetail?.toJson(),
        "bookedSlot": bookedSlot == null
            ? []
            : List<dynamic>.from(bookedSlot!.map((x) => x.toJson())),
      };
}

class Book {
  DateTime? openingTime;
  DateTime? closingTime;

  Book({
    this.openingTime,
    this.closingTime,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        openingTime: json["openingTime"] == null
            ? null
            : DateTime.parse(json["openingTime"]),
        closingTime: json["closingTime"] == null
            ? null
            : DateTime.parse(json["closingTime"]),
      );

  Map<String, dynamic> toJson() => {
        "openingTime": openingTime?.toIso8601String(),
        "closingTime": closingTime?.toIso8601String(),
      };
}
