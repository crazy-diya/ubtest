// To parse this JSON data, do
//
//     final billerPdfDownloadResponse = billerPdfDownloadResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

BillerPdfDownloadResponse billerPdfDownloadResponseFromJson(String str) => BillerPdfDownloadResponse.fromJson(json.decode(str));

String billerPdfDownloadResponseToJson(BillerPdfDownloadResponse data) => json.encode(data.toJson());

class BillerPdfDownloadResponse extends Serializable {
  String? document;

  BillerPdfDownloadResponse({
    this.document,
  });

  factory BillerPdfDownloadResponse.fromJson(Map<String, dynamic> json) => BillerPdfDownloadResponse(
    document: json["document"],
  );

  Map<String, dynamic> toJson() => {
    "document": document,
  };
}
