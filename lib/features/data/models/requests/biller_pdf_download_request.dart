// To parse this JSON data, do
//
//     final billerPdfDownloadRequest = billerPdfDownloadRequestFromJson(jsonString);

import 'dart:convert';

BillerPdfDownloadRequest billerPdfDownloadRequestFromJson(String str) => BillerPdfDownloadRequest.fromJson(json.decode(str));

String billerPdfDownloadRequestToJson(BillerPdfDownloadRequest data) => json.encode(data.toJson());

class BillerPdfDownloadRequest {
  final String? messageType;
  final String? transactionId;
  final String? transactionType;

  BillerPdfDownloadRequest({
    this.messageType,
    this.transactionId,
    this.transactionType,
  });

  factory BillerPdfDownloadRequest.fromJson(Map<String, dynamic> json) =>
      BillerPdfDownloadRequest(
        messageType: json["messageType"],
        transactionId: json["transactionId"],
        transactionType: json["transactionType"],
      );

  Map<String, dynamic> toJson() =>
      {
        "messageType": messageType,
        "transactionId": transactionId,
        "transactionType": transactionType,
      };
}
