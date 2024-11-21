// To parse this JSON data, do
//
//     final transactionHistoryPdfDownloadResponse = transactionHistoryPdfDownloadResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

TransactionHistoryPdfDownloadResponse transactionHistoryPdfDownloadResponseFromJson(String str) => TransactionHistoryPdfDownloadResponse.fromJson(json.decode(str));

String transactionHistoryPdfDownloadResponseToJson(TransactionHistoryPdfDownloadResponse data) => json.encode(data.toJson());

class TransactionHistoryPdfDownloadResponse extends Serializable{
  TransactionHistoryPdfDownloadResponse({
    this.document,
  });

  String? document;

  factory TransactionHistoryPdfDownloadResponse.fromJson(Map<String, dynamic> json) => TransactionHistoryPdfDownloadResponse(
    document: json["document"],
  );

  Map<String, dynamic> toJson() => {
    "document": document,
  };
}