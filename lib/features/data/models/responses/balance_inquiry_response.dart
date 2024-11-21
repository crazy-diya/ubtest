// To parse this JSON data, do
//
//     final balanceInquiryResponse = balanceInquiryResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

BalanceInquiryResponse balanceInquiryResponseFromJson(String str) =>
    BalanceInquiryResponse.fromJson(json.decode(str));

String balanceInquiryResponseToJson(BalanceInquiryResponse data) =>
    json.encode(data.toJson());

class BalanceInquiryResponse extends Serializable {
  BalanceInquiryResponse({
    this.accountNumber,
    this.accountBalance,
  });

  String? accountNumber;
  String? accountBalance;

  factory BalanceInquiryResponse.fromJson(Map<String, dynamic> json) =>
      BalanceInquiryResponse(
        accountNumber: json["accountNumber"],
        accountBalance: json["accountBalance"],
      );

  Map<String, dynamic> toJson() => {
        "accountNumber": accountNumber,
        "accountBalance": accountBalance,
      };
}
