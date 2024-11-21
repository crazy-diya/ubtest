// To parse this JSON data, do
//
//     final accountStatementPdfDownloadResponse = accountStatementPdfDownloadResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

AccountStatementPdfDownloadResponse accountStatementPdfDownloadResponseFromJson(
        String str) =>
    AccountStatementPdfDownloadResponse.fromJson(json.decode(str));

String accountStatementPdfDownloadResponseToJson(
        AccountStatementPdfDownloadResponse data) =>
    json.encode(data.toJson());

class AccountStatementPdfDownloadResponse extends Serializable {
  String? document;

  AccountStatementPdfDownloadResponse({
    this.document,
  });

  factory AccountStatementPdfDownloadResponse.fromJson(
          Map<String, dynamic> json) =>
      AccountStatementPdfDownloadResponse(
        document: json["document"],
      );

  Map<String, dynamic> toJson() => {
        "document": document,
      };
}
