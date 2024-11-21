// To parse this JSON data, do
//
//     final justPayInstruementsReques = justPayInstruementsRequesFromJson(jsonString);

import 'dart:convert';

JustPayInstruementsReques justPayInstruementsRequesFromJson(String str) =>
    JustPayInstruementsReques.fromJson(json.decode(str));

String justPayInstruementsRequesToJson(JustPayInstruementsReques data) =>
    json.encode(data.toJson());

class JustPayInstruementsReques {
  JustPayInstruementsReques({
    this.messageType,
    this.nic,
    this.fullName,
    this.bankCode,
    this.accountType,
    this.accountNo,
    this.nickName,
    this.enableAlert,
  });

  String? messageType;
  String? nic;
  String? fullName;
  String? bankCode;
  String? accountType;
  String? accountNo;
  String? nickName;
  bool? enableAlert;

  factory JustPayInstruementsReques.fromJson(Map<String, dynamic> json) =>
      JustPayInstruementsReques(
        messageType: json["messageType"],
        nic: json["nic"],
        fullName: json["fullName"],
        bankCode: json["bankCode"],
        accountType: json["accountType"],
        accountNo: json["accountNo"],
        nickName: json["nickName"],
        enableAlert: json["enableAlert"],
      );

  Map<String, dynamic> toJson() => {
        "messageType": messageType,
        "nic": nic,
        "fullName": fullName,
        "bankCode": bankCode,
        "accountType": accountType,
        "accountNo": accountNo,
        "nickName": nickName,
        "enableAlert": enableAlert,
      };
}
