// To parse this JSON data, do
//
//     final qrPaymentResponse = qrPaymentResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

QrPaymentResponse qrPaymentResponseFromJson(String str) => QrPaymentResponse.fromJson(json.decode(str));

String qrPaymentResponseToJson(QrPaymentResponse data) => json.encode(data.toJson());

class QrPaymentResponse extends Serializable{
  String? txnAmount;
  String? serviceCharge;
  String? status;
  String? remarks;
  String? date;
  String? referenceNo;
  String? transactionId;

  QrPaymentResponse({
    this.txnAmount,
    this.serviceCharge,
    this.status,
    this.remarks,
    this.date,
    this.referenceNo,
    this.transactionId,
  });

  factory QrPaymentResponse.fromJson(Map<String, dynamic> json) => QrPaymentResponse(
    txnAmount: json["txnAmount"],
    serviceCharge: json["serviceCharge"],
    status: json["status"],
    remarks: json["remarks"],
    date: json["date"],
    referenceNo: json["referenceNo"],
    transactionId: json["transactionId"],
  );

  Map<String, dynamic> toJson() => {
    "txnAmount": txnAmount,
    "serviceCharge": serviceCharge,
    "status": status,
    "remarks": remarks,
    "date": date,
    "referenceNo": referenceNo,
    "transactionId": transactionId,
  };
}

