// To parse this JSON data, do
//
//     final fundTransferExcelDownloadRequest = fundTransferExcelDownloadRequestFromJson(jsonString);

import 'dart:convert';

FundTransferExcelDownloadRequest fundTransferExcelDownloadRequestFromJson(String str) => FundTransferExcelDownloadRequest.fromJson(json.decode(str));

String fundTransferExcelDownloadRequestToJson(FundTransferExcelDownloadRequest data) => json.encode(data.toJson());

class FundTransferExcelDownloadRequest {
  String? messageType;
  String? transactionId;
  String? transactionType;

  FundTransferExcelDownloadRequest({
     this.messageType,
     this.transactionId,
     this.transactionType,
  });

  factory FundTransferExcelDownloadRequest.fromJson(Map<String, dynamic> json) => FundTransferExcelDownloadRequest(
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
