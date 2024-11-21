// To parse this JSON data, do
//
//     final srStatementHistoryResponse = srStatementHistoryResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

SrStatementHistoryResponse srStatementHistoryResponseFromJson(String str) => SrStatementHistoryResponse.fromJson(json.decode(str));

String srStatementHistoryResponseToJson(SrStatementHistoryResponse data) => json.encode(data.toJson());

class SrStatementHistoryResponse extends Serializable{
  final List<FindChequeBookResponseList>? findChequeBookResponseLists;

  SrStatementHistoryResponse({
    this.findChequeBookResponseLists,
  });

  factory SrStatementHistoryResponse.fromJson(Map<String, dynamic> json) => SrStatementHistoryResponse(
    findChequeBookResponseLists: json["findChequeBookResponseLists"] == null ? [] : List<FindChequeBookResponseList>.from(json["findChequeBookResponseLists"]!.map((x) => FindChequeBookResponseList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "findChequeBookResponseLists": findChequeBookResponseLists == null ? [] : List<dynamic>.from(findChequeBookResponseLists!.map((x) => x.toJson())),
  };
}

class FindChequeBookResponseList {
  final int? id;
  final String? accountNo;
  final String? collectionMethod;
  final String? branch;
  final DateTime? startDate;
  final DateTime? endDate;
  final int? serviceCharge;
  final int? deliveryCharge;
  final String? status;
  final String? address;
  final DateTime? createdDate;

  FindChequeBookResponseList({
    this.id,
    this.accountNo,
    this.collectionMethod,
    this.branch,
    this.startDate,
    this.endDate,
    this.serviceCharge,
    this.deliveryCharge,
    this.status,
    this.address,
    this.createdDate,
  });

  factory FindChequeBookResponseList.fromJson(Map<String, dynamic> json) => FindChequeBookResponseList(
    id: json["id"],
    accountNo: json["accountNo"],
    collectionMethod: json["collectionMethod"],
    branch: json["branch"],
    startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
    endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
    serviceCharge: json["serviceCharge"],
    deliveryCharge: json["deliveryCharge"],
    status: json["status"],
    createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
      address : json["address"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "accountNo": accountNo,
    "collectionMethod": collectionMethod,
    "branch": branch,
    "startDate": startDate?.toIso8601String(),
    "endDate": endDate?.toIso8601String(),
    "serviceCharge": serviceCharge,
    "deliveryCharge": deliveryCharge,
    "status": status,
    "createdDate": createdDate?.toIso8601String(),
    "address": address,
  };
}
