// // To parse this JSON data, do
// //
// //     final accountStatementsresponse = accountStatementsresponseFromJson(jsonString);
//
// import 'dart:convert';
//
// import 'package:union_bank_mobile/features/data/models/common/base_response.dart';
// import '../../../../../utils/app_extensions.dart';
//
// AccountStatementsresponse accountStatementsresponseFromJson(String str) => AccountStatementsresponse.fromJson(json.decode(str));
//
// String accountStatementsresponseToJson(AccountStatementsresponse data) => json.encode(data.toJson());
//
// class AccountStatementsresponse extends Serializable{
//   List<StatementResponseDto>? statementResponseDtos;
//   int? count;
//   double? totalCreditAmount;
//   double? totalDebitAmount;
//   DateTime? firstTxnDate;
//   DateTime? lastTxnDate;
//
//   AccountStatementsresponse({
//      this.statementResponseDtos,
//      this.count,
//      this.totalCreditAmount,
//      this.totalDebitAmount,
//      this.firstTxnDate,
//      this.lastTxnDate,
//   });
//
//   factory AccountStatementsresponse.fromJson(Map<String, dynamic> json) => AccountStatementsresponse(
//     statementResponseDtos:  json["statementResponseDtos"] == null ? [] : List<StatementResponseDto>.from(json["statementResponseDtos"]!.map((x) => StatementResponseDto.fromJson(x))),
//     count: json["count"],
//     totalCreditAmount: double.parse(json["totalCreditAmount"]??"0.0") ,
//     totalDebitAmount: double.parse(json["totalDebitAmount"]??"0.0") ,
//     firstTxnDate: DateTime.parse(
//             json["firstTxnDate"].toString().isDate() == true
//                 ? json["firstTxnDate"]
//                 : json["firstTxnDate"].toString().toValidDate()),
//         lastTxnDate: DateTime.parse(
//             json["lastTxnDate"].toString().isDate() == true
//                 ? json["lastTxnDate"]
//                 : json["lastTxnDate"].toString().toValidDate()
//     ),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "statementResponseDTOS": statementResponseDtos == null ? [] : List<dynamic>.from(statementResponseDtos!.map((x) => x.toJson())),
//     "count": count,
//     "totalCreditAmount": totalCreditAmount,
//     "totalDebitAmount": totalDebitAmount,
//     "firstTxnDate": firstTxnDate?.toIso8601String(),
//     "lastTxnDate": lastTxnDate?.toIso8601String(),
//   };
// }
//
// class StatementResponseDto {
//   String fromAccountNo;
//   String toAccountNo;
//   String transactionAmount;
//   String txnType;
//   String referenceNumber;
//   String remarks;
//   DateTime transactionDateTime;
//   String drCr;
//
//   StatementResponseDto({
//     required this.fromAccountNo,
//     required this.toAccountNo,
//     required this.transactionAmount,
//     required this.txnType,
//     required this.referenceNumber,
//     required this.remarks,
//     required this.transactionDateTime,
//     required this.drCr,
//   });
//
//   factory StatementResponseDto.fromJson(Map<String, dynamic> json) => StatementResponseDto(
//     fromAccountNo: json["fromAccountNo"],
//     toAccountNo: json["toAccountNo"],
//     transactionAmount: json["transactionAmount"],
//     txnType: json["txnType"],
//     referenceNumber: json["referenceNumber"],
//     remarks: json["remarks"],
//     transactionDateTime: DateTime.parse(
//             json["transactionDateTime"].toString().isDate() == true
//                 ? json["transactionDateTime"]
//                 : json["transactionDateTime"].toString().toValidDate()),
//     drCr: json["dr_cr"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "fromAccountNo": fromAccountNo,
//     "toAccountNo": toAccountNo,
//     "transactionAmount": transactionAmount,
//     "txnType": txnType,
//     "referenceNumber": referenceNumber,
//     "remarks": remarks,
//     "transactionDateTime": transactionDateTime.toIso8601String(),
//     "dr_cr": drCr,
//   };
// }

// To parse this JSON data, do
//
//     final accountStatementsresponse = accountStatementsresponseFromJson(jsonString);

// To parse this JSON data, do
//
//     final accountStatementsresponse = accountStatementsresponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';

AccountStatementsresponse accountStatementsresponseFromJson(String str) =>
    AccountStatementsresponse.fromJson(json.decode(str));

String accountStatementsresponseToJson(AccountStatementsresponse data) =>
    json.encode(data.toJson());

class AccountStatementsresponse extends Serializable {
  final List<StatementResponseDto>? statementResponseDtos;
  final int? count;
  final double? totalCreditAmount;
  final double? totalDebitAmount;
  final DateTime? firstTxnDate;
  final DateTime? lastTxnDate;

  AccountStatementsresponse({
    this.statementResponseDtos,
    this.count,
    this.totalCreditAmount,
    this.totalDebitAmount,
    this.firstTxnDate,
    this.lastTxnDate,
  });

  factory AccountStatementsresponse.fromJson(Map<String, dynamic> json) => AccountStatementsresponse(
    statementResponseDtos: json["statementResponseDTOS"] == null
            ? []
            : List<StatementResponseDto>.from(json["statementResponseDTOS"]!
                .map((x) => StatementResponseDto.fromJson(x))),
        count: json["count"],
        totalCreditAmount: double.parse(json["totalCreditAmount"] ?? "0.00"),
        totalDebitAmount: double.parse(json["totalDebitAmount"] ?? "0.00"),
        firstTxnDate: DateTime.parse(
            json["firstTxnDate"].toString().isDate() == true
                ? json["firstTxnDate"]
                : json["firstTxnDate"].toString().toValidDate()),
        lastTxnDate: DateTime.parse(
            json["lastTxnDate"].toString().isDate() == true
                ? json["lastTxnDate"]
                : json["lastTxnDate"].toString().toValidDate()),
      );

  Map<String, dynamic> toJson() =>
      {
        "statementResponseDTOS": statementResponseDtos == null
            ? []
            : List<dynamic>.from(statementResponseDtos!.map((x) => x.toJson())),
        "count": count,
        "totalCreditAmount": totalCreditAmount,
        "totalDebitAmount": totalDebitAmount,
        "firstTxnDate": firstTxnDate,
        "lastTxnDate": lastTxnDate,
      };
}

class StatementResponseDto {
  final String? fromAccountNo;
  final String? toAccountNo;
  final String? transactionAmount;
  final String? txnType;
  final String? referenceNumber;
  final String? remarks;
  final DateTime? transactionDateTime;
  final String? txnTime;
  final String? transactionTime;
  final String? drCr;

  StatementResponseDto({
    this.fromAccountNo,
    this.toAccountNo,
    this.transactionAmount,
    this.txnType,
    this.referenceNumber,
    this.remarks,
    this.transactionDateTime,
    this.txnTime,
    this.transactionTime,
    this.drCr,
  });

  factory StatementResponseDto.fromJson(Map<String, dynamic> json) => StatementResponseDto(
    fromAccountNo: json["fromAccountNo"],
        toAccountNo: json["toAccountNo"],
        transactionAmount: json["transactionAmount"],
        txnType: json["txnType"],
        referenceNumber: json["referenceNumber"],
        remarks: json["remarks"],
    transactionTime: json["transactionTime"],
        txnTime: json["txnTime"].toString().toValidTime(),
        transactionDateTime: DateTime.parse(
            json["transactionDateTime"].toString().isDate() == true
                ? json["transactionDateTime"]
                : json["transactionDateTime"].toString().toValidDate()),
        drCr: json["dr_cr"],
      );

  Map<String, dynamic> toJson() =>
      {
        "fromAccountNo": fromAccountNo,
        "toAccountNo": toAccountNo,
        "txnTime": txnTime,
        "transactionAmount": transactionAmount,
        "txnType": txnType,
        "referenceNumber": referenceNumber,
        "remarks": remarks,
        "transactionTime": transactionTime,
        "transactionDateTime": transactionDateTime,
        "dr_cr": drCr,
      };
}
