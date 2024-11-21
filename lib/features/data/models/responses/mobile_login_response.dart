
// To parse this JSON data, do
//
//     final mobileLoginResponse = mobileLoginResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

MobileLoginResponse mobileLoginResponseFromJson(String str) => MobileLoginResponse.fromJson(json.decode(str));

String mobileLoginResponseToJson(MobileLoginResponse data) => json.encode(data.toJson());

class MobileLoginResponse extends Serializable{
    final String? accessToken;
    final String? refreshToken;
    final int? tokenExpiresIn;
    final bool? viewAllOptions;
    final bool? otpVerificationRequired;
    final OtpResponseDto? otpResponseDto;
    final String? userName;
    final String? mobileNo;
    final String? name;
    final String? email;
    final String? nic;
    final String? nickname;
    final String? firstName;
    final String? profileImageKey;
    final int? modifiedDate;
    final DateTime? lastLoggingDate;
    final String? isMigrated;
    final String? segment;

    MobileLoginResponse({
        this.accessToken,
        this.refreshToken,
        this.tokenExpiresIn,
        this.viewAllOptions,
        this.otpVerificationRequired,
        this.otpResponseDto,
        this.userName,
        this.mobileNo,
        this.name,
        this.email,
        this.nic,
        this.nickname,
        this.firstName,
        this.profileImageKey,
        this.modifiedDate,
        this.lastLoggingDate,
        this.isMigrated,
        this.segment
    });

    factory MobileLoginResponse.fromJson(Map<String, dynamic> json) => MobileLoginResponse(
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
        tokenExpiresIn: json["tokenExpiresIn"],
        viewAllOptions: json["viewAllOptions"],
        otpVerificationRequired: json["otpVerificationRequired"],
        otpResponseDto: json["otpResponseDTO"] == null ? null : OtpResponseDto.fromJson(json["otpResponseDTO"]),
        userName: json["userName"],
        mobileNo: json["mobileNo"],
        name: json["name"],
        email: json["email"],
        nic: json["nic"],
        nickname: json["nickname"],
        firstName: json["firstName"],
        profileImageKey: json["profileImageKey"],
        modifiedDate: json["modifiedDate"],
        lastLoggingDate: json["lastLoggingDate"] == null ? null : DateTime.parse(json["lastLoggingDate"]),
        isMigrated: json["isMigrated"],
        segment: json["segment"],
    );

    @override
      Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "refreshToken": refreshToken,
        "tokenExpiresIn": tokenExpiresIn,
        "viewAllOptions": viewAllOptions,
        "otpVerificationRequired": otpVerificationRequired,
        "otpResponseDTO": otpResponseDto?.toJson(),
        "userName": userName,
        "mobileNo": mobileNo,
        "name": name,
        "email": email,
        "nic": nic,
        "nickname": nickname,
        "firstName": firstName,
        "profileImageKey": profileImageKey,
        "modifiedDate": modifiedDate,
         "isMigrated": isMigrated,
         "segment": segment,
        "lastLoggingDate": lastLoggingDate?.toIso8601String(),
    };
}

class OtpResponseDto {
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

    OtpResponseDto({
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

    factory OtpResponseDto.fromJson(Map<String, dynamic> json) => OtpResponseDto(
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
