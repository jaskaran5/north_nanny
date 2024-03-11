import 'dart:convert';

NannyDashboardModel nannyDashboardModelFromJson(String str) =>
    NannyDashboardModel.fromJson(json.decode(str));

String nannyDashboardModelToJson(NannyDashboardModel data) =>
    json.encode(data.toJson());

class NannyDashboardModel {
  int? response;
  dynamic message;
  Data? data;

  NannyDashboardModel({
    this.response,
    this.message,
    this.data,
  });

  factory NannyDashboardModel.fromJson(Map<String, dynamic> json) =>
      NannyDashboardModel(
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
  bool? isAvailable;
  String? address;
  String? name;
  double? totalRevenue;
  List<dynamic>? bookingRequest;

  Data({
    this.isAvailable,
    this.address,
    this.name,
    this.totalRevenue,
    this.bookingRequest,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        isAvailable: json["isAvailable"],
        address: json["address"] ?? '',
        name: json["name"] ?? '',
        totalRevenue: json["totalRevenue"] ?? 0.0,
        bookingRequest: json["bookingRequest"] == null
            ? []
            : List<dynamic>.from(json["bookingRequest"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "isAvailable": isAvailable,
        "address": address,
        "name": name,
        "totalRevenue": totalRevenue,
        "bookingRequest": bookingRequest == null
            ? []
            : List<dynamic>.from(bookingRequest!.map((x) => x)),
      };
}
