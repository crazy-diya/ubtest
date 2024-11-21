// To parse this JSON data, do
//
//     final accountSatementsXcelDownloadResponse = accountSatementsXcelDownloadResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

AccountSatementsXcelDownloadResponse accountSatementsXcelDownloadResponseFromJson(String str) => AccountSatementsXcelDownloadResponse.fromJson(json.decode(str));

String accountSatementsXcelDownloadResponseToJson(AccountSatementsXcelDownloadResponse data) => json.encode(data.toJson());

class AccountSatementsXcelDownloadResponse extends Serializable {
  String? document;

  AccountSatementsXcelDownloadResponse({
    this.document,
  });

  factory AccountSatementsXcelDownloadResponse.fromJson(
          Map<String, dynamic> json) =>
      AccountSatementsXcelDownloadResponse(
        document: json["document"],
      );

  Map<String, dynamic> toJson() => {
        "document": document,
  };
}
