import 'dart:convert';

ValidatorResponse validatorResponseFromJson(String str) =>
    ValidatorResponse.fromJson(json.decode(str));

String validatorResponseToJson(ValidatorResponse data) =>
    json.encode(data.toJson());

class ValidatorResponse {
  int? response;
  dynamic message;
  bool? data;

  ValidatorResponse({
    this.response,
    this.message,
    this.data,
  });

  factory ValidatorResponse.fromJson(Map<String, dynamic> json) =>
      ValidatorResponse(
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
