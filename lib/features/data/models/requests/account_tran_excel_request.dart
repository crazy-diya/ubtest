// To parse this JSON data, do
//
//     final accountTransactionExcelRequest = accountTransactionExcelRequestFromJson(jsonString);

import 'dart:convert';

AccountTransactionExcelRequest accountTransactionExcelRequestFromJson(String str) => AccountTransactionExcelRequest.fromJson(json.decode(str));

String accountTransactionExcelRequestToJson(AccountTransactionExcelRequest data) => json.encode(data.toJson());

class AccountTransactionExcelRequest {
  String messageType;
  String accountNo;
  String accountType;

  AccountTransactionExcelRequest({
    required this.messageType,
    required this.accountNo,
    required this.accountType,
  });

  factory AccountTransactionExcelRequest.fromJson(Map<String, dynamic> json) =>
      AccountTransactionExcelRequest(
        messageType: json["messageType"],
        accountNo: json["accountNo"],
        accountType: json["accountType"],
      );

  Map<String, dynamic> toJson() =>
      {
        "messageType": messageType,
        "accountNo": accountNo,
        "accountType": accountType,
      };
}
