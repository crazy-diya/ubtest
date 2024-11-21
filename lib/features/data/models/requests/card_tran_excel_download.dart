// To parse this JSON data, do
//
//     final cardTransactionExcelRequest = cardTransactionExcelRequestFromJson(jsonString);

import 'dart:convert';

CardTransactionExcelRequest cardTransactionExcelRequestFromJson(String str) => CardTransactionExcelRequest.fromJson(json.decode(str));

String cardTransactionExcelRequestToJson(CardTransactionExcelRequest data) => json.encode(data.toJson());

class CardTransactionExcelRequest {
  final String? messageType;
  final String? maskedCardNumber;
  final String? txnMonthsFrom;
  final String? txnMonthsTo;
  final double? fromAmount;
  final double? toAmount;
  final String? status;
  final String? billingStatus;

  CardTransactionExcelRequest({
    this.messageType,
    this.maskedCardNumber,
    this.txnMonthsFrom,
    this.txnMonthsTo,
    this.fromAmount,
    this.toAmount,
    this.status,
    this.billingStatus,
  });

  factory CardTransactionExcelRequest.fromJson(Map<String, dynamic> json) => CardTransactionExcelRequest(
    messageType: json["messageType"],
    maskedCardNumber: json["maskedCardNumber"],
    txnMonthsFrom: json["txnMonthsFrom"],
    txnMonthsTo: json["txnMonthsTo"],
    fromAmount: json["fromAmount"],
    toAmount: json["toAmount"],
    status: json["status"],
    billingStatus: json["billingStatus"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "maskedCardNumber": maskedCardNumber,
    "txnMonthsFrom": txnMonthsFrom,
    "txnMonthsTo": txnMonthsTo,
    "fromAmount": fromAmount,
    "toAmount": toAmount,
    "status": status,
    "billingStatus": billingStatus,
  };
}
