import 'dart:convert';

AvailabilityListModel availabilityListModelFromJson(String str) =>
    AvailabilityListModel.fromJson(json.decode(str));

String availabilityListModelToJson(AvailabilityListModel data) =>
    json.encode(data.toJson());

class AvailabilityListModel {
  int? response;
  dynamic message;
  List<AvailabilityListModelData>? data;

  AvailabilityListModel({
    this.response,
    this.message,
    this.data,
  });

  factory AvailabilityListModel.fromJson(Map<String, dynamic> json) =>
      AvailabilityListModel(
        response: json["response"],
        message: json["message"] ?? '',
        data: json["data"] == null
            ? []
            : List<AvailabilityListModelData>.from(
                json["data"].map((x) => AvailabilityListModelData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class AvailabilityListModelData {
  DateTime? openingTime;
  DateTime? closingTime;

  AvailabilityListModelData({
    this.openingTime,
    this.closingTime,
  });

  factory AvailabilityListModelData.fromJson(Map<String, dynamic> json) =>
      AvailabilityListModelData(
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
