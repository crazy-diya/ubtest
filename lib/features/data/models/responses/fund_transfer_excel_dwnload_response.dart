// To parse this JSON data, do
//
//     final fundTransferExcelDownloadResponse = fundTransferExcelDownloadResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

FundTransferExcelDownloadResponse fundTransferExcelDownloadResponseFromJson(String str) => FundTransferExcelDownloadResponse.fromJson(json.decode(str));

String fundTransferExcelDownloadResponseToJson(FundTransferExcelDownloadResponse data) => json.encode(data.toJson());

class FundTransferExcelDownloadResponse extends Serializable{
  String? document;

  FundTransferExcelDownloadResponse({
    this.document,
  });

  factory FundTransferExcelDownloadResponse.fromJson(Map<String, dynamic> json) => FundTransferExcelDownloadResponse(
    document: json["document"],
  );

  Map<String, dynamic> toJson() => {
    "document": document,
  };
}
