// To parse this JSON data, do
//
//     final accTranStatusPdfDownloadResponse = accTranStatusPdfDownloadResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

AccTranStatusPdfDownloadResponse accTranStatusPdfDownloadResponseFromJson(String str) => AccTranStatusPdfDownloadResponse.fromJson(json.decode(str));

String accTranStatusPdfDownloadResponseToJson(AccTranStatusPdfDownloadResponse data) => json.encode(data.toJson());

class AccTranStatusPdfDownloadResponse extends Serializable {
  String? document;

  AccTranStatusPdfDownloadResponse({
     this.document,
  });

  factory AccTranStatusPdfDownloadResponse.fromJson(Map<String, dynamic> json) => AccTranStatusPdfDownloadResponse(
    document: json["document"],
  );

  Map<String, dynamic> toJson() => {
    "document": document,
  };
}
