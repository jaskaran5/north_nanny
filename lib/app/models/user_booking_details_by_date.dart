import 'dart:convert';

UserBookingDetailsByDateResponseModel
    userBookingDetailsByDateResponseModelFromJson(String str) =>
        UserBookingDetailsByDateResponseModel.fromJson(json.decode(str));

String userBookingDetailsByDateResponseModelToJson(
        UserBookingDetailsByDateResponseModel data) =>
    json.encode(data.toJson());

class UserBookingDetailsByDateResponseModel {
  int? response;
  dynamic message;
  List<UserBookingDataByDate>? data;

  UserBookingDetailsByDateResponseModel({
    this.response,
    this.message,
    this.data,
  });

  factory UserBookingDetailsByDateResponseModel.fromJson(
          Map<String, dynamic> json) =>
      UserBookingDetailsByDateResponseModel(
        response: json["response"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<UserBookingDataByDate>.from(
                json["data"]!.map((x) => UserBookingDataByDate.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class UserBookingDataByDate {
  dynamic isBankDetailAdded;
  DateTime? openingTime;
  DateTime? closingTime;
  double? billAmount;
  List<String>? services;
  int? childCount;
  String? name;
  String? image;
  int? reviewCount;
  double? rating;
  int? bookingStatus;
  dynamic ratingList;
  int? bookingId;
  String? about;

  UserBookingDataByDate({
    this.isBankDetailAdded,
    this.openingTime,
    this.closingTime,
    this.billAmount,
    this.services,
    this.childCount,
    this.name,
    this.image,
    this.reviewCount,
    this.rating,
    this.bookingStatus,
    this.ratingList,
    this.bookingId,
    this.about,
  });

  factory UserBookingDataByDate.fromJson(Map<String, dynamic> json) =>
      UserBookingDataByDate(
        isBankDetailAdded: json["isBankDetailAdded"],
        openingTime: json["openingTime"] == null
            ? null
            : DateTime.parse(json["openingTime"]),
        closingTime: json["closingTime"] == null
            ? null
            : DateTime.parse(json["closingTime"]),
        billAmount: json["billAmount"]?.toDouble(),
        services: json["services"] == null
            ? []
            : List<String>.from(json["services"]!.map((x) => x)),
        childCount: json["childCount"],
        name: json["name"],
        image: json["image"],
        reviewCount: json["reviewCount"],
        rating: json["rating"],
        bookingStatus: json["bookingStatus"],
        ratingList: json["ratingList"],
        bookingId: json["bookingId"],
        about: json["about"],
      );

  Map<String, dynamic> toJson() => {
        "isBankDetailAdded": isBankDetailAdded,
        "openingTime": openingTime?.toIso8601String(),
        "closingTime": closingTime?.toIso8601String(),
        "billAmount": billAmount,
        "services":
            services == null ? [] : List<dynamic>.from(services!.map((x) => x)),
        "childCount": childCount,
        "name": name,
        "image": image,
        "reviewCount": reviewCount,
        "rating": rating,
        "bookingStatus": bookingStatus,
        "ratingList": ratingList,
        "bookingId": bookingId,
        "about": about,
      };
}
