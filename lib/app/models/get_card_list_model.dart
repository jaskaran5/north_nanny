// To parse this JSON data, do
//
//     final getCardListModel = getCardListModelFromJson(jsonString);

import 'dart:convert';

GetCardListModel getCardListModelFromJson(String str) =>
    GetCardListModel.fromJson(json.decode(str));

String getCardListModelToJson(GetCardListModel data) =>
    json.encode(data.toJson());

class GetCardListModel {
  int? response;
  dynamic message;
  List<CardData>? data;

  GetCardListModel({
    this.response,
    this.message,
    this.data,
  });

  factory GetCardListModel.fromJson(Map<String, dynamic> json) =>
      GetCardListModel(
        response: json["response"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<CardData>.from(
                json["data"]!.map((x) => CardData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CardData {
  String? cardId;
  String? cardNumber;
  int? expiryMonth;
  int? expiryYear;
  String? cardImage;
  bool isDefaultCard;

  CardData({
    this.cardId,
    this.cardNumber,
    this.expiryMonth,
    this.expiryYear,
    this.cardImage,
    this.isDefaultCard=false,
  });

  factory CardData.fromJson(Map<String, dynamic> json) => CardData(
        cardId: json["cardId"],
        cardNumber: json["cardNumber"],
        expiryMonth: json["expiryMonth"],
        expiryYear: json["expiryYear"],
        cardImage: json["cardImage"],
    isDefaultCard: json['isDefaultCard'] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "cardId": cardId,
        "cardNumber": cardNumber,
        "expiryMonth": expiryMonth,
        "expiryYear": expiryYear,
        "cardImage": cardImage,
        "isSelected": isDefaultCard,
      };
}
