// To parse this JSON data, do
//
//     final trainerProfileResponseData = trainerProfileResponseDataFromJson(jsonString);

import 'dart:convert';

OtpResponse trainerProfileResponseDataFromJson(String str) =>
    OtpResponse.fromJson(json.decode(str));

String trainerProfileResponseDataToJson(OtpResponse data) => json.encode(data.toJson());

class OtpResponse {
  String? token;

  OtpResponse({
    this.token,
  });

  factory OtpResponse.fromJson(Map<String, dynamic> json) => OtpResponse(
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
  };
}