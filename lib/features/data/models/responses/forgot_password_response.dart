// To parse this JSON data, do
//
//     final forgetPasswordResponse = forgetPasswordResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

ForgetPasswordResponse forgetPasswordResponseFromJson(String str) => ForgetPasswordResponse.fromJson(json.decode(str));

String forgetPasswordResponseToJson(ForgetPasswordResponse data) => json.encode(data.toJson());

class ForgetPasswordResponse extends Serializable{
    final String? otpTranId;
    final int? resendAttempt;
    final int? countdownTime;
    final int? otpLength;
    final String? otp;
    final String? email;
    final String? mobile;
    final String? otpType;
    final String? epicUserId;
    final String? userName;

    ForgetPasswordResponse({
        this.otpTranId,
        this.resendAttempt,
        this.countdownTime,
        this.otpLength,
        this.otp,
        this.email,
        this.mobile,
        this.otpType,
        this.epicUserId,
        this.userName,
    });

    factory ForgetPasswordResponse.fromJson(Map<String, dynamic> json) => ForgetPasswordResponse(
        otpTranId: json["otpTranId"],
        resendAttempt: json["resendAttempt"],
        countdownTime: json["countdownTime"],
        otpLength: json["otpLength"],
        otp: json["otp"],
        email: json["email"],
        mobile: json["mobile"],
        otpType: json["otpType"],
        epicUserId: json["epicUserId"],
        userName: json["userName"],
    );

    @override
      Map<String, dynamic> toJson() => {
        "otpTranId": otpTranId,
        "resendAttempt": resendAttempt,
        "countdownTime": countdownTime,
        "otpLength": otpLength,
        "otp": otp,
        "email": email,
        "mobile": mobile,
        "otpType": otpType,
        "epicUserId": epicUserId,
        "userName": userName,
    };
}
