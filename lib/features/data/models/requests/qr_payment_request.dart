// To parse this JSON data, do
//
//     final qrPaymentRequest = qrPaymentRequestFromJson(jsonString);

import 'dart:convert';

QrPaymentRequest qrPaymentRequestFromJson(String str) => QrPaymentRequest.fromJson(json.decode(str));

String qrPaymentRequestToJson(QrPaymentRequest data) => json.encode(data.toJson());

class QrPaymentRequest {
  String? messageType;
  String? txnAmount;
  int? deviceType;
  String? lankaQRcode;
  List<String>? dynamicQRdata;
  bool? serviceChargeCalculated;
  dynamic customerUtilityCommision;
  int? serviceCharge;
  String? paymentMode;
  String? mcc;
  String? instrumentId;
  String? tidNo;
  String? midNo;
  String? referenceNo;
  String? remarks;
  String? merchantAccountName;
  String? merchantAccountNo;
  String? paymentToken;

  QrPaymentRequest({
    this.messageType,
    this.txnAmount,
    this.deviceType,
    this.lankaQRcode,
    this.dynamicQRdata,
    this.serviceChargeCalculated,
    this.customerUtilityCommision,
    this.serviceCharge,
    this.paymentToken,
    this.paymentMode,
    this.mcc,
    this.instrumentId,
    this.tidNo,
    this.midNo,
    this.referenceNo,
    this.remarks,
    this.merchantAccountName,
    this.merchantAccountNo,
  });

  factory QrPaymentRequest.fromJson(Map<String, dynamic> json) => QrPaymentRequest(
    messageType: json["messageType"],
    txnAmount: json["txnAmount"],
    deviceType: json["deviceType"],
    lankaQRcode: json["lankaQRcode"],
    dynamicQRdata: List<String>.from(json["dynamicQRdata"].map((x) => x)),
    serviceChargeCalculated: json["serviceChargeCalculated"],
    customerUtilityCommision: json["customerUtilityCommision"],
    serviceCharge: json["serviceCharge"],
    paymentMode: json["paymentMode"],
    mcc: json["mcc"],
    instrumentId: json["instrumentId"],
    tidNo: json["tidNo"],
    midNo: json["midNo"],
    referenceNo: json["referenceNo"],
    remarks: json["remarks"],
    merchantAccountName: json["merchantAccountName"],
    merchantAccountNo: json["merchantAccountNo"],
    paymentToken: json["paymentToken"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "txnAmount": txnAmount,
    "deviceType": deviceType,
    "lankaQRcode": lankaQRcode,
    "dynamicQRdata": List<dynamic>.from(dynamicQRdata!.map((x) => x)),
    "serviceChargeCalculated": serviceChargeCalculated,
    "customerUtilityCommision": customerUtilityCommision,
    "serviceCharge": serviceCharge,
    "paymentMode": paymentMode,
    "mcc": mcc,
    "instrumentId": instrumentId,
    "tidNo": tidNo ?? "0000",
    "midNo": midNo,
    "referenceNo": referenceNo,
    "remarks": remarks,
    "merchantAccountName": merchantAccountName,
    "merchantAccountNo": merchantAccountNo,
    "paymentToken": paymentToken,
  };
}
