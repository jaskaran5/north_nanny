import 'dart:convert';

CommonResponse commonResponseFromJson(String str) =>
    CommonResponse.fromJson(json.decode(str));

String commonResponseToJson(CommonResponse data) => json.encode(data.toJson());

class CommonResponse {
  int? response;
  dynamic message;
  dynamic data;

  CommonResponse({
    this.response,
    this.message,
    this.data,
  });

  factory CommonResponse.fromJson(Map<String, dynamic> json) => CommonResponse(
        response: json["Response"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "Response": response,
        "message": message,
        "data": data,
      };
}
