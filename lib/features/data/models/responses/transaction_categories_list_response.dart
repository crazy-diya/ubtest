// To parse this JSON data, do
//
//     final transactionCategoriesListResponse = transactionCategoriesListResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

TransactionCategoriesListResponse transactionCategoriesListResponseFromJson(
        String str) =>
    TransactionCategoriesListResponse.fromJson(json.decode(str));

String transactionCategoriesListResponseToJson(
        TransactionCategoriesListResponse data) =>
    json.encode(data.toJson());

class TransactionCategoriesListResponse extends Serializable {
  TransactionCategoriesListResponse({
    this.txnCategories,
  });

  List<TxnCategory>? txnCategories;

  factory TransactionCategoriesListResponse.fromJson(
          Map<String, dynamic> json) =>
      TransactionCategoriesListResponse(
        txnCategories: List<TxnCategory>.from(
            json["txnCategories"].map((x) => TxnCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "txnCategories":
            List<dynamic>.from(txnCategories!.map((x) => x.toJson())),
      };
}

class TxnCategory {
  TxnCategory({
    this.id,
    this.category,
    this.status,
  });

  int? id;
  String? category;
  String? status;

  factory TxnCategory.fromJson(Map<String, dynamic> json) => TxnCategory(
        id: json["id"],
        category: json["category"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category": category,
        "status": status,
      };
}
