// To parse this JSON data, do
//
//     final srStatementRequest = srStatementRequestFromJson(jsonString);

import 'dart:convert';

SrStatementRequest srStatementRequestFromJson(String str) => SrStatementRequest.fromJson(json.decode(str));

String srStatementRequestToJson(SrStatementRequest data) => json.encode(data.toJson());

class SrStatementRequest {
  final DateTime? startDate;
  final DateTime? endDate;
  final String? accountNumber;
  final String? collectionMethod;
  final String? branch;
  final String? address;
  final int? numberOfLeaves;
  final String? serviceCharge;

  SrStatementRequest({
    this.startDate,
    this.endDate,
    this.accountNumber,
    this.collectionMethod,
    this.branch,
    this.address,
    this.numberOfLeaves,
    this.serviceCharge,
  });

  factory SrStatementRequest.fromJson(Map<String, dynamic> json) => SrStatementRequest(
    startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
    endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
    accountNumber: json["accountNumber"],
    collectionMethod: json["collectionMethod"],
    branch: json["branch"],
    address: json["address"],
    numberOfLeaves: json["numberOfLeaves"],
    serviceCharge: json["serviceCharge"],
  );

  Map<String, dynamic> toJson() => {
    "startDate": startDate?.toIso8601String(),
    "endDate": endDate?.toIso8601String(),
    "accountNumber": accountNumber,
    "collectionMethod": collectionMethod,
    "branch": branch,
    "address": address,
    "numberOfLeaves": numberOfLeaves,
    "serviceCharge": serviceCharge,
  };
}
