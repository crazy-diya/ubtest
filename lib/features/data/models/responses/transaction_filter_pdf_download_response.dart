// To parse this JSON data, do
//
//     final transactionFilteredPdfDownloadResponse = transactionFilteredPdfDownloadResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

TransactionFilteredPdfDownloadResponse transactionFilteredPdfDownloadResponseFromJson(String str) => TransactionFilteredPdfDownloadResponse.fromJson(json.decode(str));

String transactionFilteredPdfDownloadResponseToJson(TransactionFilteredPdfDownloadResponse data) => json.encode(data.toJson());

class TransactionFilteredPdfDownloadResponse extends Serializable{


  TransactionFilteredPdfDownloadResponse({
    this.document,
  });

  String? document;

  factory TransactionFilteredPdfDownloadResponse.fromJson(Map<String, dynamic> json) => TransactionFilteredPdfDownloadResponse(
    document: json["document"],
  );

  Map<String, dynamic> toJson() => {
    "document": document,
  };
}
