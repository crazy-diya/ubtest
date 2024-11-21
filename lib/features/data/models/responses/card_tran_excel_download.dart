// To parse this JSON data, do
//
//     final cardTransactionExcelResponse = cardTransactionExcelResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';



CardTransactionExcelResponse cardTransactionExcelResponseFromJson(String str) => CardTransactionExcelResponse.fromJson(json.decode(str));

String cardTransactionExcelResponseToJson(CardTransactionExcelResponse data) => json.encode(data.toJson());

class CardTransactionExcelResponse extends Serializable{
  String? document;

  CardTransactionExcelResponse({
    this.document,
  });

  factory CardTransactionExcelResponse.fromJson(Map<String, dynamic> json) =>
      CardTransactionExcelResponse(
        document: json["document"],
      );

  Map<String, dynamic> toJson() => {
        "document": document,
  };
}
