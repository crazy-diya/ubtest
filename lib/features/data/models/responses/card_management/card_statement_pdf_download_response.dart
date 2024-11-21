// To parse this JSON data, do
//
//     final cardTransactionPdfResponse = cardTransactionPdfResponseFromJson(jsonString);

import 'dart:convert';

import '../../common/base_response.dart';



CardStatementPdfResponse cardStatementPdfResponseFromJson(String str) => CardStatementPdfResponse.fromJson(json.decode(str));

String cardStatementPdfResponseToJson(CardStatementPdfResponse data) => json.encode(data.toJson());

class CardStatementPdfResponse extends Serializable{
  String? document;

  CardStatementPdfResponse({
    this.document,
  });

  factory CardStatementPdfResponse.fromJson(Map<String, dynamic> json) =>
      CardStatementPdfResponse(
        document: json["document"],
      );

  Map<String, dynamic> toJson() => {
    "document": document,
  };
}
