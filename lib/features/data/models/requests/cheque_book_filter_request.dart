// To parse this JSON data, do
//
//     final chequeBookFilterRequest = chequeBookFilterRequestFromJson(jsonString);

import 'dart:convert';

ChequeBookFilterRequest chequeBookFilterRequestFromJson(String str) => ChequeBookFilterRequest.fromJson(json.decode(str));

String chequeBookFilterRequestToJson(ChequeBookFilterRequest data) => json.encode(data.toJson());

class ChequeBookFilterRequest {
  final DateTime? fromDate;
  final DateTime? toDate;
  final String? accountNo;
  final String? collectionMethod;

  ChequeBookFilterRequest({
    this.fromDate,
    this.toDate,
    this.accountNo,
    this.collectionMethod,
  });

  factory ChequeBookFilterRequest.fromJson(Map<String, dynamic> json) => ChequeBookFilterRequest(
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
