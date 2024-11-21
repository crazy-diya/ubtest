// To parse this JSON data, do
//
//     final accountTransactionExcelResponse = accountTransactionExcelResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

AccountTransactionExcelResponse accountTransactionExcelResponseFromJson(String str) => AccountTransactionExcelResponse.fromJson(json.decode(str));

String accountTransactionExcelResponseToJson(AccountTransactionExcelResponse data) => json.encode(data.toJson());

class AccountTransactionExcelResponse extends Serializable{
  String? document;

  AccountTransactionExcelResponse({
    this.document,
  });

  factory AccountTransactionExcelResponse.fromJson(Map<String, dynamic> json) =>
      AccountTransactionExcelResponse(
        document: json["document"],
      );

  Map<String, dynamic> toJson() => {
        "document": document,
  };
}
