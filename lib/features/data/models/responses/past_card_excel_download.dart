// To parse this JSON data, do
//
//     final pastCardExcelDownloadResponse = pastCardExcelDownloadResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

PastCardExcelDownloadResponse pastCardExcelDownloadResponseFromJson(String str) => PastCardExcelDownloadResponse.fromJson(json.decode(str));

String pastCardExcelDownloadResponseToJson(PastCardExcelDownloadResponse data) => json.encode(data.toJson());

class PastCardExcelDownloadResponse extends Serializable {
  String? document;

  PastCardExcelDownloadResponse({
    this.document,
  });

  factory PastCardExcelDownloadResponse.fromJson(Map<String, dynamic> json) =>
      PastCardExcelDownloadResponse(
        document: json["document"],
      );

  Map<String, dynamic> toJson() => {
        "document": document,
  };
}
