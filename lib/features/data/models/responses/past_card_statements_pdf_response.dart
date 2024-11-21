// To parse this JSON data, do
//
//     final pastcardStatementstPdfDownloadResponse = pastcardStatementstPdfDownloadResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

PastcardStatementstPdfDownloadResponse pastcardStatementstPdfDownloadResponseFromJson(String str) => PastcardStatementstPdfDownloadResponse.fromJson(json.decode(str));

String pastcardStatementstPdfDownloadResponseToJson(PastcardStatementstPdfDownloadResponse data) => json.encode(data.toJson());

class PastcardStatementstPdfDownloadResponse extends Serializable{
  String? document;

  PastcardStatementstPdfDownloadResponse({
    this.document,
  });

  factory PastcardStatementstPdfDownloadResponse.fromJson(
          Map<String, dynamic> json) =>
      PastcardStatementstPdfDownloadResponse(
        document: json["document"],
      );

  Map<String, dynamic> toJson() => {
        "document": document,
  };
}
