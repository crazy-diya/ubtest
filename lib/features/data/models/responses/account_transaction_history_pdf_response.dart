// To parse this JSON data, do
//
//     final accountTransactionsPdfDownloadResponse = accountTransactionsPdfDownloadResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

AccountTransactionsPdfDownloadResponse accountTransactionsPdfDownloadResponseFromJson(String str) => AccountTransactionsPdfDownloadResponse.fromJson(json.decode(str));

String accountTransactionsPdfDownloadResponseToJson(AccountTransactionsPdfDownloadResponse data) => json.encode(data.toJson());

class AccountTransactionsPdfDownloadResponse extends Serializable {
  String? document;

  AccountTransactionsPdfDownloadResponse({
    this.document,
  });

  factory AccountTransactionsPdfDownloadResponse.fromJson(
          Map<String, dynamic> json) =>
      AccountTransactionsPdfDownloadResponse(
        document: json["document"],
      );

  Map<String, dynamic> toJson() => {
        "document": document,
  };
}
