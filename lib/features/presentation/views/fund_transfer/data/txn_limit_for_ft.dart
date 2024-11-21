// To parse this JSON data, do
//
//     final txnLimtForFt = txnLimtForFtFromJson(jsonString);

import 'dart:convert';

List<TxnLimtForFt> txnLimtForFtFromJson(String str) => List<TxnLimtForFt>.from(json.decode(str).map((x) => TxnLimtForFt.fromJson(x)));

String txnLimtForFtToJson(List<TxnLimtForFt> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TxnLimtForFt {
  String? transactionType;
  String? maxUserAmountPerDay;
  String? maxUserAmountPerTran;
  String? minUserAmountPerTran;
  String? maxGlobalLimitPerTran;
  String? description;

  TxnLimtForFt({
    this.transactionType,
    this.maxUserAmountPerDay,
    this.maxUserAmountPerTran,
    this.minUserAmountPerTran,
    this.maxGlobalLimitPerTran,
    this.description,
  });

  factory TxnLimtForFt.fromJson(Map<String, dynamic> json) => TxnLimtForFt(
    transactionType: json["transactionType"],
    maxUserAmountPerDay: json["maxUserAmountPerDay"],
    maxUserAmountPerTran: json["maxUserAmountPerTran"],
    minUserAmountPerTran: json["minUserAmountPerTran"],
    maxGlobalLimitPerTran: json["maxGlobalLimitPerTran"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "transactionType": transactionType,
    "maxUserAmountPerDay": maxUserAmountPerDay,
    "maxUserAmountPerTran": maxUserAmountPerTran,
    "minUserAmountPerTran": minUserAmountPerTran,
    "maxGlobalLimitPerTran": maxGlobalLimitPerTran,
    "description": description,
  };
}
