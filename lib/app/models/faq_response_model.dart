import 'dart:convert';

FaqResponseModel faqResponseModelFromJson(String str) =>
    FaqResponseModel.fromJson(json.decode(str));

String faqResponseModelToJson(FaqResponseModel data) =>
    json.encode(data.toJson());

class FaqResponseModel {
  int? response;
  dynamic message;
  List<FaqData>? data;

  FaqResponseModel({
    this.response,
    this.message,
    this.data,
  });

  factory FaqResponseModel.fromJson(Map<String, dynamic> json) =>
      FaqResponseModel(
        response: json["response"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<FaqData>.from(json["data"]!.map((x) => FaqData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class FaqData {
  int? id;
  String? questions;
  String? answer;
  DateTime? createdOn;
  int? type;
  bool? isSelected;

  FaqData({
    this.id,
    this.questions,
    this.answer,
    this.createdOn,
    this.type,
    this.isSelected,
  });

  factory FaqData.fromJson(Map<String, dynamic> json) => FaqData(
        id: json["id"],
        questions: json["questions"],
        answer: json["answer"],
        createdOn: json["createdOn"] == null
            ? null
            : DateTime.parse(json["createdOn"]),
        type: json["type"],
        isSelected: json["isSelected"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "questions": questions,
        "answer": answer,
        "createdOn": createdOn?.toIso8601String(),
        "type": type,
        "isSelected": isSelected,
      };
}
