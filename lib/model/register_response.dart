import 'dart:convert';

RegisterResponseData registerResponseData(String str) =>
    RegisterResponseData.fromJson(json.decode(str));

String registerResponseDataToJson(RegisterResponseData data) => json.encode
  (data.toJson());

class RegisterResponseData {
  int? userId;
  String? otpExpiresAt;

  RegisterResponseData({
    this.userId,
    this.otpExpiresAt,
  });

  factory RegisterResponseData.fromJson(Map<String, dynamic> json) => RegisterResponseData(
    userId: json["user_id"],
    otpExpiresAt: json["otp_expires_at"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "otp_expires_at": otpExpiresAt,
  };
}