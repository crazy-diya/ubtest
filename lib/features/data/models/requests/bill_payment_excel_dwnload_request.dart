// To parse this JSON data, do
//
//     final fundTransferExcelDownloadRequest = fundTransferExcelDownloadRequestFromJson(jsonString);

import 'dart:convert';

BillPaymentExcelDownloadRequest billPaymentExcelDownloadRequestFromJson(String str) => BillPaymentExcelDownloadRequest.fromJson(json.decode(str));

String fundTransferExcelDownloadRequestToJson(BillPaymentExcelDownloadRequest data) => json.encode(data.toJson());

class BillPaymentExcelDownloadRequest {
  String? messageType;
  String? transactionId;
  String? transactionType;

  BillPaymentExcelDownloadRequest({
     this.messageType,
     this.transactionId,
     this.transactionType,
  });

  factory BillPaymentExcelDownloadRequest.fromJson(Map<String, dynamic> json) => BillPaymentExcelDownloadRequest(
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
