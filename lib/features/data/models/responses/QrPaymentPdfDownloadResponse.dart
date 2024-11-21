// To parse this JSON data, do
//
//     final qrPaymentPdfDownloadResponse = qrPaymentPdfDownloadResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

QrPaymentPdfDownloadResponse qrPaymentPdfDownloadResponseFromJson(String str) => QrPaymentPdfDownloadResponse.fromJson(json.decode(str));

String qrPaymentPdfDownloadResponseToJson(QrPaymentPdfDownloadResponse data) => json.encode(data.toJson());

class QrPaymentPdfDownloadResponse extends Serializable {
  String? document;

  QrPaymentPdfDownloadResponse({
    this.document,
  });

  factory QrPaymentPdfDownloadResponse.fromJson(Map<String, dynamic> json) => QrPaymentPdfDownloadResponse(
    document: json["document"],
  );

  Map<String, dynamic> toJson() => {
    "document": document,
  };
}
