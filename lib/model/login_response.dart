import 'dart:convert';

LoginResponseData trainerProfileResponseDataFromJson(String str) => LoginResponseData.fromJson(json.decode(str));

String trainerProfileResponseDataToJson(LoginResponseData data) => json.encode(data.toJson());

class LoginResponseData {
  int? userId;
  String? otpExpiresAt;

  LoginResponseData({
    this.userId,
    this.otpExpiresAt,
  });

  factory LoginResponseData.fromJson(Map<String, dynamic> json) => LoginResponseData(
    userId: json["user_id"],
    otpExpiresAt: json["otp_expires_at"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "otp_expires_at": otpExpiresAt,
  };
}