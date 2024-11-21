// To parse this JSON data, do
//
//     final justPayVerificationRequest = justPayVerificationRequestFromJson(jsonString);

import 'dart:convert';

JustPayVerificationRequest justPayVerificationRequestFromJson(String str) =>
    JustPayVerificationRequest.fromJson(json.decode(str));

String justPayVerificationRequestToJson(JustPayVerificationRequest data) =>
    json.encode(data.toJson());

class JustPayVerificationRequest {
  JustPayVerificationRequest({
    this.messageType,
    this.mobileNo,
    this.nic,
    this.referralCode,
    this.obType,
    this.email,
  });

  String? messageType;
  String? mobileNo;
  String? nic;
  String? referralCode;
  String? obType;
  String? email;

  factory JustPayVerificationRequest.fromJson(Map<String, dynamic> json) =>
      JustPayVerificationRequest(
        messageType: json["messageType"],
        mobileNo: json["mobileNo"],
        nic: json["nic"],
        referralCode: json["referralCode"],
        obType: json["obType"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "messageType": messageType,
        "mobileNo": mobileNo,
        "nic": nic,
        "referralCode": referralCode,
        "obType": obType,
        "email": email,
      };
}
