// To parse this JSON data, do
//
//     final otpResponse = otpResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

OtpResponse otpResponseFromJson(String str) =>
    OtpResponse.fromJson(json.decode(str));

String otpResponseToJson(OtpResponse data) => json.encode(data.toJson());

class OtpResponse extends Serializable {
  OtpResponse({
    this.responseCode,
    this.responseDescription,
    this.otpTranId,
    this.resendAttempt,
    this.countdownTime,
    this.otpLength,
    this.otp,
    this.email,
    this.mobile,
    this.otpType,
  });

  String? responseCode;
  String? responseDescription;
  String? otpTranId;
  int? resendAttempt;
  int? countdownTime;
  int? otpLength;
  String? otp;
  String? email;
  String? mobile;
  String? otpType;

  factory OtpResponse.fromJson(Map<String, dynamic> json) => OtpResponse(
        responseCode: json["responseCode"],
        responseDescription: json["responseDescription"],
        otpTranId: json["otpTranId"],
        resendAttempt: json["resendAttempt"],
        countdownTime: json["countdownTime"],
        otpLength: json["otpLength"],
        otp: json["otp"],
        email: json["email"],
        mobile: json["mobile"],
        otpType: json["otpType"],
      );

  Map<String, dynamic> toJson() => {
        "responseCode": responseCode,
        "responseDescription": responseDescription,
        "otpTranId": otpTranId,
        "resendAttempt": resendAttempt,
        "countdownTime": countdownTime,
        "otpLength": otpLength,
        "otp": otp,
        "email": email,
        "mobile": mobile,
        "otpType": otpType,
      };
}
