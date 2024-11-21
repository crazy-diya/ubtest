// To parse this JSON data, do
//
//     final loanHistoryPdfResponse = loanHistoryPdfResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';



LoanHistoryPdfResponse loanHistoryPdfResponseFromJson(String str) => LoanHistoryPdfResponse.fromJson(json.decode(str));

String loanHistoryPdfResponseToJson(LoanHistoryPdfResponse data) => json.encode(data.toJson());

class LoanHistoryPdfResponse extends Serializable {
  String? document;

  LoanHistoryPdfResponse({
    this.document,
  });

  factory LoanHistoryPdfResponse.fromJson(Map<String, dynamic> json) =>
      LoanHistoryPdfResponse(
        document: json["document"],
      );

  Map<String, dynamic> toJson() => {
        "document": document,
  };
}
