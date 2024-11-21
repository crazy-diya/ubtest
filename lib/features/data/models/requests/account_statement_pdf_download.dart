// To parse this JSON data, do
//
//     final accountStatementPdfDownloadRequest = accountStatementPdfDownloadRequestFromJson(jsonString);

import 'dart:convert';

AccountStatementPdfDownloadRequest accountStatementPdfDownloadRequestFromJson(String str) => AccountStatementPdfDownloadRequest.fromJson(json.decode(str));

String accountStatementPdfDownloadRequestToJson(AccountStatementPdfDownloadRequest data) => json.encode(data.toJson());

class AccountStatementPdfDownloadRequest {
  String? messageType;
  int? page;
  int? size;
  String? accountNo;
  String? accountType;
  String? fromDate;
  String? toDate;
  String? fromAmount;
  String? toAmount;
  String? status;

  AccountStatementPdfDownloadRequest({
    this.messageType,
    this.page,
    this.size,
    this.accountNo,
    this.accountType,
    this.fromDate,
    this.toDate,
    this.fromAmount,
    this.toAmount,
    this.status,
  });

  factory AccountStatementPdfDownloadRequest.fromJson(Map<String, dynamic> json) => AccountStatementPdfDownloadRequest(
    messageType: json["messageType"],
        page: json["page"],
        size: json["size"],
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
        "page": page,
        "size": size,
        "accountNo": accountNo,
        "accountType": accountType,
        "fromDate": fromDate,
        "toDate": toDate,
        "fromAmount": fromAmount,
        "toAmount": toAmount,
        "status": status,
      };
}
