// To parse this JSON data, do
//
//     final fundTransferPdfDownloadResponse = fundTransferPdfDownloadResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

FundTransferPdfDownloadResponse fundTransferPdfDownloadResponseFromJson(String str) => FundTransferPdfDownloadResponse.fromJson(json.decode(str));

String fundTransferPdfDownloadResponseToJson(FundTransferPdfDownloadResponse data) => json.encode(data.toJson());

class FundTransferPdfDownloadResponse extends Serializable{
  String? document;

  FundTransferPdfDownloadResponse({
     this.document,
  });

  factory FundTransferPdfDownloadResponse.fromJson(Map<String, dynamic> json) => FundTransferPdfDownloadResponse(
    document: json["document"],
  );

  Map<String, dynamic> toJson() => {
    "document": document,
  };
}
