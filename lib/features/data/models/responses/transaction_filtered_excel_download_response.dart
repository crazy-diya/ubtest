// To parse this JSON data, do
//
//     final transactionFilteredPdfDownloadResponse = transactionFilteredPdfDownloadResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

TransactionFilteredExcelDownloadResponse transactionFilteredPdfDownloadResponseFromJson(String str) => TransactionFilteredExcelDownloadResponse.fromJson(json.decode(str));

String transactionFilteredPdfDownloadResponseToJson(TransactionFilteredExcelDownloadResponse data) => json.encode(data.toJson());

class TransactionFilteredExcelDownloadResponse extends Serializable{


  TransactionFilteredExcelDownloadResponse({
    this.document,
  });

  String? document;

  factory TransactionFilteredExcelDownloadResponse.fromJson(Map<String, dynamic> json) => TransactionFilteredExcelDownloadResponse(
    document: json["document"],
  );

  Map<String, dynamic> toJson() => {
    "document": document,
  };
}
