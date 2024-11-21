// To parse this JSON data, do
//
//     final transactionStatusPdfResponse = transactionStatusPdfResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

TransactionStatusPdfResponse transactionStatusPdfResponseFromJson(String str) => TransactionStatusPdfResponse.fromJson(json.decode(str));

String transactionStatusPdfResponseToJson(TransactionStatusPdfResponse data) => json.encode(data.toJson());

class TransactionStatusPdfResponse extends Serializable{
  String? document;

  TransactionStatusPdfResponse({
    this.document,
  });

  factory TransactionStatusPdfResponse.fromJson(Map<String, dynamic> json) =>
      TransactionStatusPdfResponse(
        document: json["document"],
      );

  Map<String, dynamic> toJson() => {
        "document": document,
  };
}
