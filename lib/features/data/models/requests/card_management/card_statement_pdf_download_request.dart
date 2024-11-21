// To parse this JSON data, do
//
//     final pastcardStatementstPdfDownloadRequest = pastcardStatementstPdfDownloadRequestFromJson(jsonString);

import 'dart:convert';

CardStateentPdfDownloadRequest cardStateentPdfDownloadRequestFromJson(String str) => CardStateentPdfDownloadRequest.fromJson(json.decode(str));

String cardStateentPdfDownloadRequestToJson(CardStateentPdfDownloadRequest data) => json.encode(data.toJson());

class CardStateentPdfDownloadRequest {
  String messageType;
  String? billMonth;
  String? maskedPrimaryCardNumber;

  CardStateentPdfDownloadRequest({
    required this.messageType,
    this.maskedPrimaryCardNumber,
    this.billMonth,
  });

  factory CardStateentPdfDownloadRequest.fromJson(Map<String, dynamic> json) => CardStateentPdfDownloadRequest(
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
