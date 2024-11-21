// To parse this JSON data, do
//
//     final qrPaymentPdfDownloadRequest = qrPaymentPdfDownloadRequestFromJson(jsonString);

import 'dart:convert';

QrPaymentPdfDownloadRequest qrPaymentPdfDownloadRequestFromJson(String str) => QrPaymentPdfDownloadRequest.fromJson(json.decode(str));

String qrPaymentPdfDownloadRequestToJson(QrPaymentPdfDownloadRequest data) => json.encode(data.toJson());

class QrPaymentPdfDownloadRequest {
  String? messageType;
  String? txnAmount;
  String? serviceCharge;
  String? status;
  String? remarks;
  String? date;
  String? referenceNo;
  String? transactionId;

  QrPaymentPdfDownloadRequest({
    this.messageType,
    this.txnAmount,
    this.serviceCharge,
    this.status,
    this.remarks,
    this.date,
    this.referenceNo,
    this.transactionId,
  });

  factory QrPaymentPdfDownloadRequest.fromJson(Map<String, dynamic> json) => QrPaymentPdfDownloadRequest(
    messageType: json["messageType"],
    txnAmount: json["txnAmount"],
    serviceCharge: json["serviceCharge"],
    status: json["status"],
    remarks: json["remarks"],
    date: json["date"],
    referenceNo: json["referenceNo"],
    transactionId: json["transactionId"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "txnAmount": txnAmount,
    "serviceCharge": serviceCharge,
    "status": status,
    "remarks": remarks,
    "date": date,
    "referenceNo": referenceNo,
    "transactionId": transactionId,
  };
}
