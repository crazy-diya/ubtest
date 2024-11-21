// To parse this JSON data, do
//
//     final accountVerificationRequest = accountVerificationRequestFromJson(jsonString);

import 'dart:convert';

AccountVerificationRequest accountVerificationRequestFromJson(String str) => AccountVerificationRequest.fromJson(json.decode(str));

String accountVerificationRequestToJson(AccountVerificationRequest data) => json.encode(data.toJson());

class AccountVerificationRequest {
  AccountVerificationRequest({
    this.accountNo,
    this.messageType,
  });

  String? accountNo;
  String? messageType;

  factory AccountVerificationRequest.fromJson(Map<String, dynamic> json) => AccountVerificationRequest(
    accountNo: json["accountNo"],
    messageType: json["messageType"],
  );

  Map<String, dynamic> toJson() => {
    "accountNo": accountNo,
    "messageType": messageType,
  };
}
