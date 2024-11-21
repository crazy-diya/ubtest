// // To parse this JSON data, do
// //
// //     final justPayAccountOnboardingResponse = justPayAccountOnboardingResponseFromJson(jsonString);

// import 'dart:convert';

// import '../common/base_response.dart';

// JustPayAccountOnboardingResponse justPayAccountOnboardingResponseFromJson(
//         String str) =>
//     JustPayAccountOnboardingResponse.fromJson(json.decode(str));

// String justPayAccountOnboardingResponseToJson(
//         JustPayAccountOnboardingResponse data) =>
//     json.encode(data.toJson());

// class JustPayAccountOnboardingResponse extends Serializable {
//   JustPayAccountOnboardingResponse({
//     this.otpTranId,
//     this.resendAttempt,
//     this.countdownTime,
//     this.otpLength,
//     this.otpType,
//     // this.otp,
//     // this.email,
//     // this.mobile,
//   });

//   String? otpTranId;
//   int? resendAttempt;
//   int? countdownTime;
//   int? otpLength;
//   String? otpType;
//   // dynamic otp;
//   // String? email;
//   // String? mobile;

//   factory JustPayAccountOnboardingResponse.fromJson(
//           Map<String, dynamic> json) =>
//       JustPayAccountOnboardingResponse(
//         otpTranId: json["otpTranId"],
//         resendAttempt: json["resendAttempt"],
//         countdownTime: json["countdownTime"],
//         otpLength: json["otpLength"],
//         otpType: json["otpType"],
//         // otp: json["otp"],
//         // email: json["email"],
//         // mobile: json["mobile"],
//       );

//   Map<String, dynamic> toJson() => {
//         "otpTranId": otpTranId,
//         "resendAttempt": resendAttempt,
//         "countdownTime": countdownTime,
//         "otpLength": otpLength,
//         "otpType": otpType,
//         // "otp": otp,
//         // "email": email,
//         // "mobile": mobile,
//       };
// }








// To parse this JSON data, do
//
//     final justPayAccountOnboardingResponse = justPayAccountOnboardingResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

JustPayAccountOnboardingResponse justPayAccountOnboardingResponseFromJson(String str) => JustPayAccountOnboardingResponse.fromJson(json.decode(str));

String justPayAccountOnboardingResponseToJson(JustPayAccountOnboardingResponse data) => json.encode(data.toJson());

class JustPayAccountOnboardingResponse extends Serializable{
    OtpResult? otpResult;

    JustPayAccountOnboardingResponse({
        this.otpResult,
    });

    factory JustPayAccountOnboardingResponse.fromJson(Map<String, dynamic> json) => JustPayAccountOnboardingResponse(
        otpResult: json["otpResult"] == null ? null : OtpResult.fromJson(json["otpResult"]),
    );

    Map<String, dynamic> toJson() => {
        "otpResult": otpResult?.toJson(),
    };
}

class OtpResult {
    String? otpTranId;
    int? resendAttempt;
    int? countdownTime;
    int? otpLength;
    String? otpType;

    OtpResult({
        this.otpTranId,
        this.resendAttempt,
        this.countdownTime,
        this.otpLength,
        this.otpType,
    });

    factory OtpResult.fromJson(Map<String, dynamic> json) => OtpResult(
        otpTranId: json["otpTranId"],
        resendAttempt: json["resendAttempt"],
        countdownTime: json["countdownTime"],
        otpLength: json["otpLength"],
        otpType: json["otpType"],
    );

    Map<String, dynamic> toJson() => {
        "otpTranId": otpTranId,
        "resendAttempt": resendAttempt,
        "countdownTime": countdownTime,
        "otpLength": otpLength,
        "otpType": otpType,
    };
}

