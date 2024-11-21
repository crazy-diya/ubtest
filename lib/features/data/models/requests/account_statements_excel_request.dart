// To parse this JSON data, do
//
//     final accountSatementsXcelDownloadRequest = accountSatementsXcelDownloadRequestFromJson(jsonString);

import 'dart:convert';

AccountSatementsXcelDownloadRequest accountSatementsXcelDownloadRequestFromJson(String str) => AccountSatementsXcelDownloadRequest.fromJson(json.decode(str));

String accountSatementsXcelDownloadRequestToJson(AccountSatementsXcelDownloadRequest data) => json.encode(data.toJson());

class AccountSatementsXcelDownloadRequest {
  String? messageType;
  String? accountNo;
  String? accountType;
  String? fromDate;
  String? toDate;
  String? fromAmount;
  String? toAmount;
  String? status;

  AccountSatementsXcelDownloadRequest({
    this.messageType,
    this.accountNo,
    this.accountType,
    this.fromDate,
    this.toDate,
    this.fromAmount,
    this.toAmount,
    this.status,
  });

  factory AccountSatementsXcelDownloadRequest.fromJson(Map<String, dynamic> json) => AccountSatementsXcelDownloadRequest(
    messageType: json["messageType"],
        accountNo: json["accountNo"],
        accountType: json["accountType"],
        fromDate: json["fromDate"],
        toDate: json["toDate"],
        fromAmount: json["fromAmount"],
        toAmount: json["toAmount"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() =>
      {
        "messageType": messageType,
        "accountNo": accountNo,
        "accountType": accountType,
        "fromDate": fromDate,
        "toDate": toDate,
        "fromAmount": fromAmount,
        "toAmount": toAmount,
        "status": status,
      };
}