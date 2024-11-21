// To parse this JSON data, do
//
//     final srStatementRequest = srStatementRequestFromJson(jsonString);

import 'dart:convert';

SrStatementHistoryRequest srStatementRequestFromJson(String str) => SrStatementHistoryRequest.fromJson(json.decode(str));

String srStatementRequestToJson(SrStatementHistoryRequest data) => json.encode(data.toJson());

class SrStatementHistoryRequest {
  final DateTime? fromDate;
  final DateTime? toDate;
  final String? accountNo;
  final String? collectionMethod;

  SrStatementHistoryRequest({
    this.fromDate,
    this.toDate,
    this.accountNo,
    this.collectionMethod,
  });

  factory SrStatementHistoryRequest.fromJson(Map<String, dynamic> json) => SrStatementHistoryRequest(
    fromDate: json["fromDate"] == null ? null : DateTime.parse(json["fromDate"]),
    toDate: json["toDate"] == null ? null : DateTime.parse(json["toDate"]),
    accountNo: json["accountNo"],
    collectionMethod: json["collectionMethod"],
  );

  Map<String, dynamic> toJson() => {
    "fromDate": fromDate?.toIso8601String(),
    "toDate": toDate?.toIso8601String(),
    "accountNo": accountNo,
    "collectionMethod": collectionMethod,
  };
}
