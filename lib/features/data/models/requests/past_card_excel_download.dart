// To parse this JSON data, do
//
//     final pastCardExcelDownloadRequest = pastCardExcelDownloadRequestFromJson(jsonString);

import 'dart:convert';

PastCardExcelDownloadRequest pastCardExcelDownloadRequestFromJson(String str) => PastCardExcelDownloadRequest.fromJson(json.decode(str));

String pastCardExcelDownloadRequestToJson(PastCardExcelDownloadRequest data) => json.encode(data.toJson());

class PastCardExcelDownloadRequest {
  String messageType;
  String? billMonth;
  String? maskedPrimaryCardNumber;

  PastCardExcelDownloadRequest({
    required this.messageType,
    this.maskedPrimaryCardNumber,
    this.billMonth,
  });

  factory PastCardExcelDownloadRequest.fromJson(Map<String, dynamic> json) => PastCardExcelDownloadRequest(
    messageType: json["messageType"],
    maskedPrimaryCardNumber: json["maskedPrimaryCardNumber"],
    billMonth: json["billMonth"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "maskedPrimaryCardNumber": maskedPrimaryCardNumber,
    "billMonth": billMonth,
  };
}
