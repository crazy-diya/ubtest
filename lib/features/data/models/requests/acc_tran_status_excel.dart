// To parse this JSON data, do
//
//     final accTranStatusExcelDownloadRequest = accTranStatusExcelDownloadRequestFromJson(jsonString);

import 'dart:convert';

AccTranStatusExcelDownloadRequest accTranStatusExcelDownloadRequestFromJson(String str) => AccTranStatusExcelDownloadRequest.fromJson(json.decode(str));

String accTranStatusExcelDownloadRequestToJson(AccTranStatusExcelDownloadRequest data) => json.encode(data.toJson());

class AccTranStatusExcelDownloadRequest {
  final String? messageType;
  final String? paidFromAccountName;
  final String? paidFromAccountNo;
  final String? paidToAccountName;
  final String? paidToAccountNo;
  final String? amount;
  final String? serviceCharge;
  final String? transactionCategory;
  final String? remarks;
  final String? beneficiaryEmail;
  final String? beneficiaryMobileNo;
  final String? dateAndTime;
  final String? referenceId;

  AccTranStatusExcelDownloadRequest({
    this.messageType,
    this.paidFromAccountName,
    this.paidFromAccountNo,
    this.paidToAccountName,
    this.paidToAccountNo,
    this.amount,
    this.serviceCharge,
    this.transactionCategory,
    this.remarks,
    this.beneficiaryEmail,
    this.beneficiaryMobileNo,
    this.dateAndTime,
    this.referenceId,
  });

  factory AccTranStatusExcelDownloadRequest.fromJson(Map<String, dynamic> json) => AccTranStatusExcelDownloadRequest(
    messageType: json["messageType"],
        paidFromAccountName: json["paidFromAccountName"],
        paidFromAccountNo: json["paidFromAccountNo"],
        paidToAccountName: json["paidToAccountName"],
        paidToAccountNo: json["paidToAccountNo"],
        amount: json["amount"],
        serviceCharge: json["serviceCharge"],
        transactionCategory: json["transactionCategory"],
        remarks: json["remarks"],
        beneficiaryEmail: json["beneficiaryEmail"],
        beneficiaryMobileNo: json["beneficiaryMobileNo"],
        dateAndTime: json["dateAndTime"],
        referenceId: json["referenceId"],
      );

  Map<String, dynamic> toJson() =>
      {
        "messageType": messageType,
        "paidFromAccountName": paidFromAccountName,
        "paidFromAccountNo": paidFromAccountNo,
        "paidToAccountName": paidToAccountName,
        "paidToAccountNo": paidToAccountNo,
        "amount": amount,
        "serviceCharge": serviceCharge,
        "transactionCategory": transactionCategory,
        "remarks": remarks,
        "beneficiaryEmail": beneficiaryEmail,
        "beneficiaryMobileNo": beneficiaryMobileNo,
        "dateAndTime": dateAndTime,
        "referenceId": referenceId,
      };
}
