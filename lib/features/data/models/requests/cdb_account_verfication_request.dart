// To parse this JSON data, do
//
//     final cdbAccountVerificationRequest = cdbAccountVerificationRequestFromJson(jsonString);

import 'dart:convert';

CdbAccountVerificationRequest cdbAccountVerificationRequestFromJson(
        String str) =>
    CdbAccountVerificationRequest.fromJson(json.decode(str));

String cdbAccountVerificationRequestToJson(
        CdbAccountVerificationRequest data) =>
    json.encode(data.toJson());

class CdbAccountVerificationRequest {
  CdbAccountVerificationRequest({
    this.messageType,
    this.obType,
    this.accountNo,
    this.referralCode,
    this.nickName,
    this.identificationType,
    this.identificationNo,
  });

  String? messageType;
  String? obType;
  String? accountNo;
  String? referralCode;
  String? nickName;
  String? identificationType;
  String? identificationNo;

  factory CdbAccountVerificationRequest.fromJson(Map<String, dynamic> json) =>
      CdbAccountVerificationRequest(
          messageType: json["messageType"],
          obType: json["obType"],
          accountNo: json["accountNo"],
          referralCode: json["referralCode"],
          nickName: json["nickName"],
          identificationType: json["identificationType"],
          identificationNo: json["identificationNo"]);

  Map<String, dynamic> toJson() => {
        "messageType": messageType,
        "obType": obType,
        "accountNo": accountNo,
        "referralCode": referralCode,
        "nickName": nickName,
        "identificationType": identificationType,
        "identificationNo": identificationNo,
      };
}
