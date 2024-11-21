// To parse this JSON data, do
//
//     final cdbAccountVerificationRequest = cdbAccountVerificationRequestFromJson(jsonString);

import 'dart:convert';

UBAccountVerificationRequest ubAccountVerificationRequestFromJson(String str) => UBAccountVerificationRequest.fromJson(json.decode(str));

String ubAccountVerificationRequestToJson(UBAccountVerificationRequest data) => json.encode(data.toJson());

class UBAccountVerificationRequest {
  UBAccountVerificationRequest({
    this.messageType,
    this.obType,
    this.accountNo,
    this.referralCode,
  });

  String? messageType;
  String? obType;
  String? accountNo;
  String? referralCode;

  factory UBAccountVerificationRequest.fromJson(Map<String, dynamic> json) => UBAccountVerificationRequest(
    messageType: json["messageType"],
    obType: json["obType"],
    accountNo: json["accountNo"],
    referralCode: json["referralCode"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "obType": obType,
    "accountNo": accountNo,
    "referralCode": referralCode,
  };
}
