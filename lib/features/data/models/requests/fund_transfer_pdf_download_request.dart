// To parse this JSON data, do
//
//     final fundTransferPdfDownloadRequest = fundTransferPdfDownloadRequestFromJson(jsonString);

import 'dart:convert';

FundTransferPdfDownloadRequest fundTransferPdfDownloadRequestFromJson(String str) => FundTransferPdfDownloadRequest.fromJson(json.decode(str));

String fundTransferPdfDownloadRequestToJson(FundTransferPdfDownloadRequest data) => json.encode(data.toJson());

class FundTransferPdfDownloadRequest {
  String? messageType;
  String? transactionId;
  String? transactionType;

  FundTransferPdfDownloadRequest({
     this.messageType,
     this.transactionId,
     this.transactionType,
  });

  factory FundTransferPdfDownloadRequest.fromJson(Map<String, dynamic> json) => FundTransferPdfDownloadRequest(
    messageType: json["messageType"],
    transactionId: json["transactionId"],
    transactionType: json["transactionType"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "transactionId": transactionId,
    "transactionType": transactionType,
  };
}
