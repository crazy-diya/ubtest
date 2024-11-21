// To parse this JSON data, do
//
//     final loanHistoryresponse = loanHistoryresponseFromJson(jsonString);

// import 'dart:convert';

// import '../common/base_response.dart';

// LoanHistoryresponse loanHistoryresponseFromJson(String str) => LoanHistoryresponse.fromJson(json.decode(str));

// String loanHistoryresponseToJson(LoanHistoryresponse data) => json.encode(data.toJson());

// class LoanHistoryresponse extends Serializable{
//   List<LoanHistoryResponseDto>? loanHistoryResponseDtos;
//   int count;

//   LoanHistoryresponse({
//      this.loanHistoryResponseDtos,
//     required this.count,
//   });

//   factory LoanHistoryresponse.fromJson(Map<String, dynamic> json) => LoanHistoryresponse(
//     loanHistoryResponseDtos: List<LoanHistoryResponseDto>.from(json["loanHistoryResponseDTOS"].map((x) => LoanHistoryResponseDto.fromJson(x))),
//     count: json["count"],
//   );

//   Map<String, dynamic> toJson() => {
//     "loanHistoryResponseDTOS": List<dynamic>.from(loanHistoryResponseDtos!.map((x) => x.toJson())),
//     "count": count,
//   };
// }

// class LoanHistoryResponseDto extends Serializable {
//   String fromAccountNo;
//   String toAccountNo;
//   String transactionAmount;
//   String referenceNumber;
//   String remarks;
//   DateTime transactionDateTime;

//   LoanHistoryResponseDto({
//     required this.fromAccountNo,
//     required this.toAccountNo,
//     required this.transactionAmount,
//     required this.referenceNumber,
//     required this.remarks,
//     required this.transactionDateTime,
//   });

//   factory LoanHistoryResponseDto.fromJson(Map<String, dynamic> json) => LoanHistoryResponseDto(
//     fromAccountNo: json["fromAccountNo"],
//     toAccountNo: json["toAccountNo"],
//     transactionAmount: json["transactionAmount"],
//     referenceNumber: json["referenceNumber"],
//     remarks: json["remarks"],
//     transactionDateTime: DateTime.parse(json["transactionDateTime"]),
//   );

//   Map<String, dynamic> toJson() => {
//     "fromAccountNo": fromAccountNo,
//     "toAccountNo": toAccountNo,
//     "transactionAmount": transactionAmount,
//     "referenceNumber": referenceNumber,
//     "remarks": remarks,
//     "transactionDateTime": transactionDateTime.toIso8601String(),
//   };
// }


// To parse this JSON data, do
//
//     final loanHistoryresponse = loanHistoryresponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';

LoanHistoryresponse loanHistoryresponseFromJson(String str) => LoanHistoryresponse.fromJson(json.decode(str));

String loanHistoryresponseToJson(LoanHistoryresponse data) => json.encode(data.toJson());

class LoanHistoryresponse  extends Serializable{
    final List<LoanHistoryResponseDto>? loanHistoryResponseDtos;
    final int? count;
    final DateTime? firstTxnDate;
    final DateTime? lastTxnDate;

    LoanHistoryresponse({
        this.loanHistoryResponseDtos,
        this.count,
        this.firstTxnDate,
        this.lastTxnDate,
    });

    factory LoanHistoryresponse.fromJson(Map<String, dynamic> json) => LoanHistoryresponse(
        loanHistoryResponseDtos: json["loanHistoryResponseDTOS"] == null ? [] : List<LoanHistoryResponseDto>.from(json["loanHistoryResponseDTOS"]!.map((x) => LoanHistoryResponseDto.fromJson(x))),
        count: json["count"],
        firstTxnDate: DateTime.parse(json["firstTxnDate"].toString().isDate() == true
            ? json["firstTxnDate"]
            : json["firstTxnDate"].toString().toValidDate()),
        lastTxnDate:DateTime.parse(json["lastTxnDate"].toString().isDate() == true
            ? json["lastTxnDate"]
            : json["lastTxnDate"].toString().toValidDate()),
    );

    Map<String, dynamic> toJson() => {
        "loanHistoryResponseDTOS": loanHistoryResponseDtos == null ? [] : List<dynamic>.from(loanHistoryResponseDtos!.map((x) => x.toJson())),
        "count": count,
        "firstTxnDate": firstTxnDate,
        "lastTxnDate": lastTxnDate,
    };
}

class LoanHistoryResponseDto {
    final String? fromAccountNo;
    final String? toAccountNo;
    final String? transactionAmount;
    final String? referenceNumber;
    final String? remarks;
    final String? description;
    final DateTime? transactionDateTime;

    LoanHistoryResponseDto({
        this.fromAccountNo,
        this.toAccountNo,
        this.transactionAmount,
        this.referenceNumber,
        this.remarks,
        this.description,
        this.transactionDateTime,
    });

    factory LoanHistoryResponseDto.fromJson(Map<String, dynamic> json) => LoanHistoryResponseDto(
        fromAccountNo: json["fromAccountNo"],
        toAccountNo: json["toAccountNo"],
        transactionAmount: json["transactionAmount"],
        referenceNumber: json["referenceNumber"],
        remarks: json["remarks"],
        description: json["description"],
        transactionDateTime:  DateTime.parse(json["transactionDateTime"].toString().isDate() == true
            ? json["transactionDateTime"]
            : json["transactionDateTime"].toString().toValidDate()),
    );

    Map<String, dynamic> toJson() => {
        "fromAccountNo": fromAccountNo,
        "toAccountNo": toAccountNo,
        "transactionAmount": transactionAmount,
        "referenceNumber": referenceNumber,
        "remarks": remarks,
        "description": description,
        "transactionDateTime": transactionDateTime,
    };
}

