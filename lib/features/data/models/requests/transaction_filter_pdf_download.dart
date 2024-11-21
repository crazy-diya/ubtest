// To parse this JSON data, do
//
//     final transactionFilteredPdfDownloadRequest = transactionFilteredPdfDownloadRequestFromJson(jsonString);

import 'dart:convert';

TransactionFilteredPdfDownloadRequest transactionFilteredPdfDownloadRequestFromJson(String str) => TransactionFilteredPdfDownloadRequest.fromJson(json.decode(str));

String transactionFilteredPdfDownloadRequestToJson(TransactionFilteredPdfDownloadRequest data) => json.encode(data.toJson());

class TransactionFilteredPdfDownloadRequest {
  final String? messageType;
  final int? page;
  final int? size;
  final String? fromDate;
  final String? toDate;
  final double? fromAmount;
  final double? toAmount;
  final String? tranType;
  final String? accountNo;
  final String? channel;

  TransactionFilteredPdfDownloadRequest({
    this.messageType,
    this.page,
    this.size,
    this.fromDate,
    this.toDate,
    this.fromAmount,
    this.toAmount,
    this.tranType,
    this.accountNo,
    this.channel,
  });

  factory TransactionFilteredPdfDownloadRequest.fromJson(Map<String, dynamic> json) => TransactionFilteredPdfDownloadRequest(
    messageType: json["messageType"],
    page: json["page"],
    size: json["size"],
    fromDate: json["fromDate"] == null ? null : json["fromDate"],
    toDate: json["toDate"] == null ? null : json["toDate"],
    fromAmount: json["fromAmount"],
    toAmount: json["toAmount"],
    tranType: json["tranType"],
    accountNo: json["accountNo"],
    channel: json["channel"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "page": page,
    "size": size,
    "fromDate": fromDate,
    "toDate": toDate,
    "fromAmount": fromAmount,
    "toAmount": toAmount,
    "tranType": tranType,
    "accountNo": accountNo,
    "channel": channel,
  };
}
