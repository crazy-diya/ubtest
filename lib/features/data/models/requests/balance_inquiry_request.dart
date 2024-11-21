// To parse this JSON data, do
//
//     final balanceInquiryRequest = balanceInquiryRequestFromJson(jsonString);

import 'dart:convert';

BalanceInquiryRequest balanceInquiryRequestFromJson(String str) =>
    BalanceInquiryRequest.fromJson(json.decode(str));

String balanceInquiryRequestToJson(BalanceInquiryRequest data) =>
    json.encode(data.toJson());

class BalanceInquiryRequest {
  BalanceInquiryRequest({
    this.messageType,
    this.accountNumber,
  });

  String? messageType;
  String? accountNumber;

  factory BalanceInquiryRequest.fromJson(Map<String, dynamic> json) =>
      BalanceInquiryRequest(
        messageType: json["messageType"],
        accountNumber: json["accountNumber"],
      );

  Map<String, dynamic> toJson() => {
        "messageType": messageType,
        "accountNumber": accountNumber,
      };
}
