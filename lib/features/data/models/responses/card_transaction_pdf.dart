// To parse this JSON data, do
//
//     final cardTransactionPdfResponse = cardTransactionPdfResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';



CardTransactionPdfResponse cardTransactionPdfResponseFromJson(String str) => CardTransactionPdfResponse.fromJson(json.decode(str));

String cardTransactionPdfResponseToJson(CardTransactionPdfResponse data) => json.encode(data.toJson());

class CardTransactionPdfResponse extends Serializable{
  String? document;

  CardTransactionPdfResponse({
    this.document,
  });

  factory CardTransactionPdfResponse.fromJson(Map<String, dynamic> json) =>
      CardTransactionPdfResponse(
        document: json["document"],
      );

  Map<String, dynamic> toJson() => {
        "document": document,
  };
}
