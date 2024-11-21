// // To parse this JSON data, do
// //
// //     final pastCardStatementsresponse = pastCardStatementsresponseFromJson(jsonString);
//
// import 'dart:convert';
//
// import 'package:union_bank_mobile/features/data/models/common/base_response.dart';
//
// PastCardStatementsresponse pastCardStatementsresponseFromJson(String str) => PastCardStatementsresponse.fromJson(json.decode(str));
//
// String pastCardStatementsresponseToJson(PastCardStatementsresponse data) => json.encode(data.toJson());
//
// class PastCardStatementsresponse extends Serializable{
//   List<CreditCardPastStatementDetailsDto> creditCardPastStatementDetailsDtos;
//
//   PastCardStatementsresponse({
//     required this.creditCardPastStatementDetailsDtos,
//   });
//
//   factory PastCardStatementsresponse.fromJson(Map<String, dynamic> json) => PastCardStatementsresponse(
//     creditCardPastStatementDetailsDtos: List<CreditCardPastStatementDetailsDto>.from(json["creditCardPastStatementDetailsDTOS"].map((x) => CreditCardPastStatementDetailsDto.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "creditCardPastStatementDetailsDTOS": List<dynamic>.from(creditCardPastStatementDetailsDtos.map((x) => x.toJson())),
//   };
// }
//
// class CreditCardPastStatementDetailsDto {
//   String description;
//   String amount;
//   String referenceId;
//   DateTime date;
//   String txnType;
//
//   CreditCardPastStatementDetailsDto({
//     required this.description,
//     required this.amount,
//     required this.referenceId,
//     required this.date,
//     required this.txnType,
//   });
//
//   factory CreditCardPastStatementDetailsDto.fromJson(Map<String, dynamic> json) => CreditCardPastStatementDetailsDto(
//     description: json["description"],
//     amount: json["amount"],
//     referenceId: json["referenceID"],
//     date: DateTime.parse(json["date"]),
//     txnType: json["txnType"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "description": description,
//     "amount": amount,
//     "referenceID": referenceId,
//     "date": date.toIso8601String(),
//     "txnType": txnType,
//   };
// }


// To parse this JSON data, do
//
//     final pastCardStatementsresponse = pastCardStatementsresponseFromJson(jsonString);

// To parse this JSON data, do
//
//     final pastCardStatementsresponse = pastCardStatementsresponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

PastCardStatementsresponse pastCardStatementsresponseFromJson(String str) => PastCardStatementsresponse.fromJson(json.decode(str));

String pastCardStatementsresponseToJson(PastCardStatementsresponse data) => json.encode(data.toJson());

class PastCardStatementsresponse extends Serializable{
  final List<PrimaryTxnDetail>? primaryTxnDetails;

  PastCardStatementsresponse({
    this.primaryTxnDetails,
  });

  factory PastCardStatementsresponse.fromJson(Map<String, dynamic> json) => PastCardStatementsresponse(
    primaryTxnDetails: json["primaryTxnDetails"] == null ? [] : List<PrimaryTxnDetail>.from(json["primaryTxnDetails"]!.map((x) => PrimaryTxnDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "primaryTxnDetails": primaryTxnDetails == null ? [] : List<dynamic>.from(primaryTxnDetails!.map((x) => x.toJson())),
  };
}

class PrimaryTxnDetail {
  final String? resAmtInLkr;
  final String? resTxnAmount;
  final DateTime? resTransPostDate;
  final String? resTransactedMaksedCardNum;
  final String? resDebitsCreditIndicator;
  final String? resTxnCurrency;
  final String? resRefNo;
  final String? resTransDesc;

  PrimaryTxnDetail({
    this.resAmtInLkr,
    this.resTxnAmount,
    this.resTransPostDate,
    this.resTransactedMaksedCardNum,
    this.resDebitsCreditIndicator,
    this.resTxnCurrency,
    this.resRefNo,
    this.resTransDesc,
  });

  factory PrimaryTxnDetail.fromJson(Map<String, dynamic> json) => PrimaryTxnDetail(
    resAmtInLkr: json["resAmtInLKR"],
    resTxnAmount: json["resTxnAmount"],
    resTransPostDate: json["resTransPostDate"] == null ? null : DateTime.parse(json["resTransPostDate"]),
    resTransactedMaksedCardNum: json["resTransactedMaksedCardNum"],
    resDebitsCreditIndicator: json["resDebitsCreditIndicator"],
    resTxnCurrency: json["resTxnCurrency"],
    resRefNo: json["resRefNo"],
    resTransDesc: json["resTransDesc"],
  );

  Map<String, dynamic> toJson() => {
    "resAmtInLKR": resAmtInLkr,
    "resTxnAmount": resTxnAmount,
    "resTransPostDate": resTransPostDate?.toIso8601String(),
    "resTransactedMaksedCardNum": resTransactedMaksedCardNum,
    "resDebitsCreditIndicator": resDebitsCreditIndicator,
    "resTxnCurrency": resTxnCurrency,
    "resRefNo": resRefNo,
    "resTransDesc": resTransDesc,
  };
}
