// // To parse this JSON data, do
// //
// //     final cardTxnHistoryRequest = cardTxnHistoryRequestFromJson(jsonString);
//
// To parse this JSON data, do
//
//     final cardTxnHistoryRequest = cardTxnHistoryRequestFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

CardTxnHistoryRequest cardTxnHistoryRequestFromJson(String str) => CardTxnHistoryRequest.fromJson(json.decode(str));

String cardTxnHistoryRequestToJson(CardTxnHistoryRequest data) => json.encode(data.toJson());

class CardTxnHistoryRequest extends Equatable{
    final String? messageType;
    final String? maskedCardNumber;
    final String? txnMonthsFrom;
    final String? txnMonthsTo;
    final int? page;
    final int? size;
    final num? fromAmount;
    final num? toAmount;
    final String? status;
    final String? billingStatus;

    CardTxnHistoryRequest({
        this.messageType,
        this.maskedCardNumber,
        this.txnMonthsFrom,
        this.txnMonthsTo,
        this.page,
        this.size,
        this.fromAmount,
        this.toAmount,
        this.status,
        this.billingStatus,
    });

    factory CardTxnHistoryRequest.fromJson(Map<String, dynamic> json) => CardTxnHistoryRequest(
        messageType: json["messageType"],
        maskedCardNumber: json["maskedCardNumber"],
        txnMonthsFrom: json["txnMonthsFrom"],
        txnMonthsTo: json["txnMonthsTo"],
        page: json["page"],
        size: json["size"],
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
        "page": page,
        "size": size,
        "fromAmount": fromAmount,
        "toAmount": toAmount,
        "status": status,
        "billingStatus": billingStatus,
    };

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}







// import 'dart:convert';
//
// import 'package:equatable/equatable.dart';
//
// CardTxnHistoryRequest cardTxnHistoryRequestFromJson(String str) => CardTxnHistoryRequest.fromJson(json.decode(str));
//
// String cardTxnHistoryRequestToJson(CardTxnHistoryRequest data) => json.encode(data.toJson());
//
// class CardTxnHistoryRequest extends Equatable{
//     final String? maskedCardNumber;
//     final String? messageType;
//     final String? txnMonthsFrom;
//     final String? txnMonthsTo;
//
//     CardTxnHistoryRequest({
//         this.maskedCardNumber,
//         this.messageType,
//         this.txnMonthsFrom,
//         this.txnMonthsTo,
//     });
//
//     factory CardTxnHistoryRequest.fromJson(Map<String, dynamic> json) => CardTxnHistoryRequest(
//         maskedCardNumber: json["maskedCardNumber"],
//         messageType: json["messageType"],
//         txnMonthsFrom: json["txnMonthsFrom"],
//         txnMonthsTo: json["txnMonthsTo"],
//     );
//
//     Map<String, dynamic> toJson() => {
//         "maskedCardNumber": maskedCardNumber,
//         "messageType": messageType,
//         "txnMonthsFrom": txnMonthsFrom,
//         "txnMonthsTo": txnMonthsTo,
//     };
//
//       @override
//       List<Object?> get props => [maskedCardNumber,messageType,txnMonthsFrom,txnMonthsTo];
// }
