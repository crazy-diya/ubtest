// To parse this JSON data, do
//
//     final accountStatementsrequest = accountStatementsrequestFromJson(jsonString);

import 'dart:convert';

AccountStatementsrequest accountStatementsrequestFromJson(String str) => AccountStatementsrequest.fromJson(json.decode(str));

String accountStatementsrequestToJson(AccountStatementsrequest data) => json.encode(data.toJson());

class AccountStatementsrequest {
  String messageType;
  int? page;
  int? size;
  String? fromDate;
  String? toDate;
  int? fromAmount;
  int? toAmount;
  String? status;
  String? accountNo;
  String? accountType;

  AccountStatementsrequest({
    required this.messageType,
     this.page,
     this.size,
     this.fromDate,
     this.toDate,
     this.fromAmount,
     this.toAmount,
     this.status,
    required this.accountNo,
    this.accountType
  });

  factory AccountStatementsrequest.fromJson(Map<String, dynamic> json) => AccountStatementsrequest(
    messageType: json["messageType"],
    page: json["page"],
    size: json["size"],
    fromDate: json["fromDate"],
    toDate: json["toDate"],
    fromAmount: json["fromAmount"],
    toAmount: json["toAmount"],
    status: json["status"],
    accountNo: json["accountNo"],
    accountType: json["accountType"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "page": page,
    "size": size,
    "fromDate": fromDate,
    "toDate": toDate,
    "fromAmount": fromAmount,
    "toAmount": toAmount,
    "status": status,
    "accountNo": accountNo,
    "accountType":accountType
  };
}
