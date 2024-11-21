// To parse this JSON data, do
//
//     final challengeRequest = challengeRequestFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

ChallengeRequest challengeRequestFromJson(String str) =>
    ChallengeRequest.fromJson(json.decode(str));

String challengeRequestToJson(ChallengeRequest data) =>
    json.encode(data.toJson());

class ChallengeRequest extends Equatable {
  const ChallengeRequest({
    this.messageType,
    this.deviceId,
    this.otpType,
    this.otpTranId,
    this.epicUserId,
    this.smsOtp,
    this.emailOtp,
    this.justpayOtp,
    this.otp,
    this.action,
    this.id,
    this.ids,
  });

  final String? messageType;
  final String? deviceId;
  final String? otpType;
  final String? otpTranId;
final List<int>? ids;
  final String? otp;
  final String? epicUserId;
  final String? emailOtp;
  final String? smsOtp;
  final String? justpayOtp;
  final String? id;
  final String? action;

  factory ChallengeRequest.fromJson(Map<String, dynamic> json) =>
      ChallengeRequest(
        messageType: json["messageType"],
        deviceId: json["deviceId"],
        otpType: json["otpType"],
        otpTranId: json["otpTranId"],
        otp: json["otp"],
        epicUserId: json["epicUserId"],
        emailOtp: json["emailOtp"],
        smsOtp: json["smsOtp"],
        justpayOtp: json["justpayOtp"],
        id: json["id"],
        action: json["action"],
        ids: json["ids"],
      );

  Map<String, dynamic> toJson() => {
        "messageType": messageType,
        "deviceId": deviceId,
        "otpType": otpType,
        "otpTranId": otpTranId,
        "otp": otp,
        "epicUserId": epicUserId,
        "emailOtp": emailOtp,
        "smsOtp": smsOtp,
        "justpayOtp": justpayOtp,
        "action": action,
        "id": id,
        "ids": ids,
      };

  @override
  List<Object?> get props => [
        messageType,
        otpTranId,
        deviceId,
        otpType,
        epicUserId,
        emailOtp,
        smsOtp,
        otp,
        justpayOtp,
        id,
        ids,
        action
      ];
}
