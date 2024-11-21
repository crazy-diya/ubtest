// To parse this JSON data, do
//
//     final accountTransactionHistorysrequest = accountTransactionHistorysrequestFromJson(jsonString);

import 'dart:convert';

AccountTransactionHistorysrequest accountTransactionHistorysrequestFromJson(String str) => AccountTransactionHistorysrequest.fromJson(json.decode(str));

String accountTransactionHistorysrequestToJson(AccountTransactionHistorysrequest data) => json.encode(data.toJson());

class AccountTransactionHistorysrequest {
  String messageType;
  int page;
  int size;
  String accountNo;
  String accountType;
  

  AccountTransactionHistorysrequest({
    required this.messageType,
    required this.page,
    required this.size,
    required this.accountNo,
    required this.accountType
  });

  factory AccountTransactionHistorysrequest.fromJson(Map<String, dynamic> json) => AccountTransactionHistorysrequest(
    messageType: json["messageType"],
    page: json["page"],
    size: json["size"],
    accountNo: json["accountNo"],
    accountType: json["accountType"]
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "page": page,
    "size": size,
    "accountNo": accountNo,
    "accountType": accountType,
  };
}
