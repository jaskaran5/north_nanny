import 'dart:convert';

GetBankDetailResponse getBankDetailResponseFromJson(String str) =>
    GetBankDetailResponse.fromJson(json.decode(str));

String getBankDetailResponseToJson(GetBankDetailResponse data) =>
    json.encode(data.toJson());

class GetBankDetailResponse {
  int? response;
  dynamic message;
  Data? data;

  GetBankDetailResponse({
    this.response,
    this.message,
    this.data,
  });

  factory GetBankDetailResponse.fromJson(Map<String, dynamic> json) =>
      GetBankDetailResponse(
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
  int? bankId;
  String? bankName;
  String? accountHolderName;
  String? accountNumber;
  String? routingNumber;
  dynamic stripeAccNumber;

  Data({
    this.bankId,
    this.bankName,
    this.accountHolderName,
    this.accountNumber,
    this.routingNumber,
    this.stripeAccNumber,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        bankId: json["bankId"],
        bankName: json["bankName"],
        accountHolderName: json["accountHolderName"],
        accountNumber: json["accountNumber"],
        routingNumber: json["routingNumber"],
        stripeAccNumber: json["stripeAccNumber"],
      );

  Map<String, dynamic> toJson() => {
        "bankId": bankId,
        "bankName": bankName,
        "accountHolderName": accountHolderName,
        "accountNumber": accountNumber,
        "routingNumber": routingNumber,
        "stripeAccNumber": stripeAccNumber,
      };
}
