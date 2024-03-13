import 'dart:convert';

NannyBookingDetails nannyBookingDetailsFromJson(String str) =>
    NannyBookingDetails.fromJson(json.decode(str));

String nannyBookingDetailsToJson(NannyBookingDetails data) =>
    json.encode(data.toJson());

class NannyBookingDetails {
  int? response;
  String? message;
  List<DateTime>? data;

  NannyBookingDetails({
    this.response,
    this.message,
    this.data,
  });

  factory NannyBookingDetails.fromJson(Map<String, dynamic> json) =>
      NannyBookingDetails(
        response: json["response"] ?? 0,
        message: json["message"] ?? '',
        data: json["data"] == null
            ? []
            : List<DateTime>.from(json["data"]!.map((x) => DateTime.parse(x))),
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toIso8601String())),
      };
}
