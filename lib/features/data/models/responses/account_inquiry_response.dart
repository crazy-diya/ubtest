// To parse this JSON data, do
//
//     final accountInquiryResponse = accountInquiryResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';


AccountInquiryResponse accountInquiryResponseFromJson(String str) =>
    AccountInquiryResponse.fromJson(json.decode(str));

String accountInquiryResponseToJson(AccountInquiryResponse data) =>
    json.encode(data.toJson());

class AccountInquiryResponse extends Serializable {
  AccountInquiryResponse({
    this.accounts,
  });

  List<Account>? accounts;

  factory AccountInquiryResponse.fromJson(Map<String, dynamic> json) =>
      AccountInquiryResponse(
        accounts: List<Account>.from(
            json["accounts"].map((x) => Account.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "accounts": List<dynamic>.from(accounts!.map((x) => x.toJson())),
      };
}

class Account {
  Account({
    this.accountNumber,
    this.status,
    this.productCode,
    this.currency,
    this.balance,
  });

  String? accountNumber;
  String? status;
  String? productCode;
  String? currency;
  String? balance;

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        accountNumber: json["accountNumber"],
        status: json["status"],
        productCode: json["productCode"],
        currency: json["currency"],
        balance: json["balance"],
      );

  Map<String, dynamic> toJson() => {
        "accountNumber": accountNumber,
        "status": status,
        "productCode": productCode,
        "currency": currency,
        "balance": balance,
      };
}
