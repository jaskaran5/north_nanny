import 'dart:convert';

AvailabilityByDayModel availabilityByDayModelFromJson(String str) =>
    AvailabilityByDayModel.fromJson(json.decode(str));

String availabilityByDayModelToJson(AvailabilityByDayModel data) =>
    json.encode(data.toJson());

class AvailabilityByDayModel {
  int? response;
  dynamic message;
  Data? data;

  AvailabilityByDayModel({
    this.response,
    this.message,
    this.data,
  });

  factory AvailabilityByDayModel.fromJson(Map<String, dynamic> json) =>
      AvailabilityByDayModel(
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
  DateTime? openingTime;
  DateTime? closingTime;

  Data({
    this.openingTime,
    this.closingTime,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
