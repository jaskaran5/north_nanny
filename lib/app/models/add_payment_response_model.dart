import 'dart:convert';

AddPaymentMethodModel addPaymentMethodModelFromJson(String str) =>
    AddPaymentMethodModel.fromJson(json.decode(str));

String addPaymentMethodModelToJson(AddPaymentMethodModel data) =>
    json.encode(data.toJson());

class AddPaymentMethodModel {
  int response;
  dynamic message;
  String data;

  AddPaymentMethodModel({
    required this.response,
    required this.message,
    required this.data,
  });

  factory AddPaymentMethodModel.fromJson(Map<String, dynamic> json) =>
      AddPaymentMethodModel(
        response: json["response"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "message": message,
        "data": data,
      };
}
