// To parse this JSON data, do
//
//     final transactionLimitResponse = transactionLimitResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

TransactionLimitResponse transactionLimitResponseFromJson(String str) =>
    TransactionLimitResponse.fromJson(json.decode(str));

String transactionLimitResponseToJson(TransactionLimitResponse data) =>
    json.encode(data.toJson());

class TransactionLimitResponse extends Serializable {
  TransactionLimitResponse({
    this.count,
    this.txnLimitDetails,
  });

  int? count;
  List<TxnLimitDetail>? txnLimitDetails;

  factory TransactionLimitResponse.fromJson(Map<String, dynamic> json) =>
      TransactionLimitResponse(
        count: json["count"],
        txnLimitDetails: json["txnLimitDetails"] != null
            ? List<TxnLimitDetail>.from(
                json["txnLimitDetails"].map((x) => TxnLimitDetail.fromJson(x)))
            : List.empty(),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "txnLimitDetails":
            List<dynamic>.from(txnLimitDetails!.map((x) => x.toJson())),
      };
}

class TxnLimitDetail {
  TxnLimitDetail({
    this.code,
    this.description,
    this.maxAmountPerDay,
  });

  String? code;
  String? description;
  double? maxAmountPerDay;

  factory TxnLimitDetail.fromJson(Map<String, dynamic> json) => TxnLimitDetail(
        code: json["code"],
        description: json["description"],
        maxAmountPerDay: json["maxAmountPerDay"] != null
            ? json["maxAmountPerDay"].toDouble()
            : null,
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "description": description,
        "maxAmountPerDay": maxAmountPerDay,
      };
}
