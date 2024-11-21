// To parse this JSON data, do
//
//     final cardTransactionPdfRequest = cardTransactionPdfRequestFromJson(jsonString);

import 'dart:convert';

CardTransactionPdfRequest cardTransactionPdfRequestFromJson(String str) => CardTransactionPdfRequest.fromJson(json.decode(str));

String cardTransactionPdfRequestToJson(CardTransactionPdfRequest data) => json.encode(data.toJson());

class CardTransactionPdfRequest {
  final String? messageType;
  final String? maskedCardNumber;
  final String? txnMonthsFrom;
  final String? txnMonthsTo;
  final double? fromAmount;
  final double? toAmount;
  final String? status;
  final String? billingStatus;

  CardTransactionPdfRequest({
    this.messageType,
    this.maskedCardNumber,
    this.txnMonthsFrom,
    this.txnMonthsTo,
    this.fromAmount,
    this.toAmount,
    this.status,
    this.billingStatus,
  });

  factory CardTransactionPdfRequest.fromJson(Map<String, dynamic> json) => CardTransactionPdfRequest(
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
