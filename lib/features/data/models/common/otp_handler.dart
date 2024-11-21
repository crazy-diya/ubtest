import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final otpHandler = otpHandlerFromJson(jsonString);

// To parse this JSON data, do
//
//     final otpHandler = otpHandlerFromJson(jsonString);

OtpHandler otpHandlerFromJson(String str) => OtpHandler.fromJson(json.decode(str));

String otpHandlerToJson(OtpHandler data) => json.encode(data.toJson());

class OtpHandler {
    final String? previousRoute;
    final DateTime? otpSendTime;
    final bool? isResendAttemptOver;
    final String? otpTranId;
    final String? otpType;
    final String? email;
    final String? mobile;
    final int? resendAttempt;
    final String? countdownTime;
    final int? otpLength;

    OtpHandler({
        this.previousRoute,
        this.otpSendTime,
        this.isResendAttemptOver,
        this.otpTranId,
        this.otpType,
        this.email,
        this.mobile,
        this.resendAttempt,
        this.countdownTime,
        this.otpLength,
    });

    factory OtpHandler.fromJson(Map<String, dynamic> json) => OtpHandler(
        previousRoute: json["previousRoute"],
        otpSendTime: json["otpSendTime"]== null ? null : DateTime.parse(json["otpSendTime"]),
        isResendAttemptOver: json["isResendAttemptOver"],
        otpTranId: json["otpTranId"],
        otpType: json["otpType"],
        email: json["email"],
        mobile: json["mobile"],
        resendAttempt: json["resendAttempt"],
        countdownTime: json["countdownTime"],
        otpLength: json["otpLength"],
    );

    Map<String, dynamic> toJson() => {
        "previousRoute": previousRoute,
        "otpSendTime": otpSendTime?.toIso8601String(),
        "isResendAttemptOver": isResendAttemptOver,
        "otpTranId": otpTranId,
        "otpType": otpType,
        "email": email,
        "mobile": mobile,
        "resendAttempt": resendAttempt,
        "countdownTime": countdownTime,
        "otpLength": otpLength,
    };

  @override
  String toString() {
    return 'OtpHandler(previousRoute: $previousRoute, otpSendTime: $otpSendTime, isResendAttemptOver: $isResendAttemptOver, otpTranId: $otpTranId, otpType: $otpType, email: $email, mobile: $mobile, resendAttempt: $resendAttempt, countdownTime: $countdownTime, otpLength: $otpLength)';
  }
}

