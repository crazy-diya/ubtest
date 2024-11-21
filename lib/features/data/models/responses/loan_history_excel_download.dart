// To parse this JSON data, do
//
//     final loanHistoryExcelResponse = loanHistoryExcelResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';



LoanHistoryExcelResponse loanHistoryExcelResponseFromJson(String str) => LoanHistoryExcelResponse.fromJson(json.decode(str));

String loanHistoryExcelResponseToJson(LoanHistoryExcelResponse data) => json.encode(data.toJson());

class LoanHistoryExcelResponse extends Serializable{
  String? document;

  LoanHistoryExcelResponse({
    this.document,
  });

  factory LoanHistoryExcelResponse.fromJson(Map<String, dynamic> json) =>
      LoanHistoryExcelResponse(
        document: json["document"],
      );

  Map<String, dynamic> toJson() => {
        "document": document,
  };
}
