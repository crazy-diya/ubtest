// To parse this JSON data, do
//
//     final accountTransactionsPdfDownloadRequest = accountTransactionsPdfDownloadRequestFromJson(jsonString);

import 'dart:convert';

AccountTransactionsPdfDownloadRequest accountTransactionsPdfDownloadRequestFromJson(String str) => AccountTransactionsPdfDownloadRequest.fromJson(json.decode(str));

String accountTransactionsPdfDownloadRequestToJson(AccountTransactionsPdfDownloadRequest data) => json.encode(data.toJson());

class AccountTransactionsPdfDownloadRequest {
  String? messageType;
  String? accountNo;
  String? accountType;

  AccountTransactionsPdfDownloadRequest({
    this.messageType,
    this.accountNo,
    this.accountType,
  });

  factory AccountTransactionsPdfDownloadRequest.fromJson(
          Map<String, dynamic> json) =>
      AccountTransactionsPdfDownloadRequest(
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
