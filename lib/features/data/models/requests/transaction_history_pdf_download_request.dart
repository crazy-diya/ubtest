// To parse this JSON data, do
//
//     final transactionHistoryPdfDownloadRequest = transactionHistoryPdfDownloadRequestFromJson(jsonString);

import 'dart:convert';

TransactionHistoryPdfDownloadRequest transactionHistoryPdfDownloadRequestFromJson(String str) => TransactionHistoryPdfDownloadRequest.fromJson(json.decode(str));

String transactionHistoryPdfDownloadRequestToJson(TransactionHistoryPdfDownloadRequest data) => json.encode(data.toJson());

class TransactionHistoryPdfDownloadRequest {
  TransactionHistoryPdfDownloadRequest({
    this.messageType,
    this.transactionId,
  });

  String? messageType;
  String? transactionId;

  factory TransactionHistoryPdfDownloadRequest.fromJson(Map<String, dynamic> json) => TransactionHistoryPdfDownloadRequest(
    messageType: json["messageType"],
    transactionId: json["transactionId"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "transactionId": transactionId,
  };
}
