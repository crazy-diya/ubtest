
// To parse this JSON data, do
//
//     final mobileLoginResponse = mobileLoginResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

TemporaryLoginResponse temporaryLoginResponseFromJson(String str) => TemporaryLoginResponse.fromJson(json.decode(str));

String temporaryLoginResponseToJson(TemporaryLoginResponse data) => json.encode(data.toJson());

class TemporaryLoginResponse extends Serializable{
    final TemporaryLoginOtpResponseDto? otpResponseDto;
    final int? modifiedDate;
    final String? status;
    final String? epicUserId;

    TemporaryLoginResponse({
        this.otpResponseDto,
        this.modifiedDate,
        this.status,
        this.epicUserId
    });

    factory TemporaryLoginResponse.fromJson(Map<String, dynamic> json) => TemporaryLoginResponse(
        otpResponseDto: json["otpResponseDTO"] == null ? null : TemporaryLoginOtpResponseDto.fromJson(json["otpResponseDTO"]),
        modifiedDate: json["modifiedDate"],
        status:json["status"],
        epicUserId:json["epicUserId"],
    );

    @override
    Map<String, dynamic> toJson() => {
        "otpResponseDTO": otpResponseDto?.toJson(),
        "modifiedDate": modifiedDate,
        "status": status,
        "epicUserId": epicUserId,
    };
}

class TemporaryLoginOtpResponseDto {
    final String? otpTranId;
    final int? resendAttempt;
    final int? countdownTime;
    final int? otpLength;
    final String? otp;
    final String? email;
    final String? mobile;
    final String? otpType;
    final String? smsOtp;
    final String? emailOtp;

    TemporaryLoginOtpResponseDto({
        this.otpTranId,
        this.resendAttempt,
        this.countdownTime,
        this.otpLength,
        this.otp,
        this.email,
        this.mobile,
        this.otpType,
        this.smsOtp,
        this.emailOtp,
    });

    factory TemporaryLoginOtpResponseDto.fromJson(Map<String, dynamic> json) => TemporaryLoginOtpResponseDto(
        otpTranId: json["otpTranId"],
        resendAttempt: json["resendAttempt"],
        countdownTime: json["countdownTime"],
        otpLength: json["otpLength"],
        otp: json["otp"],
        email: json["email"],
        mobile: json["mobile"],
        otpType: json["otpType"],
        smsOtp: json["smsOtp"],
        emailOtp: json["emailOtp"],
    );

    Map<String, dynamic> toJson() => {
        "otpTranId": otpTranId,
        "resendAttempt": resendAttempt,
        "countdownTime": countdownTime,
        "otpLength": otpLength,
        "otp": otp,
        "email": email,
        "mobile": mobile,
        "otpType": otpType,
        "smsOtp": smsOtp,
        "emailOtp": emailOtp,
    };
}

