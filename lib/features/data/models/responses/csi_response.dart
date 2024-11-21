// To parse this JSON data, do
//
//     final csiResponse = csiResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

CsiResponse csiResponseFromJson(String str) => CsiResponse.fromJson(json.decode(str));

String csiResponseToJson(CsiResponse data) => json.encode(data.toJson());

class CsiResponse extends Serializable{
  final List<CsiDataList>? csiDataList;

  CsiResponse({
    this.csiDataList,
  });

  factory CsiResponse.fromJson(Map<String, dynamic> json) => CsiResponse(
    csiDataList: json["csiDataList"] == null ? [] : List<CsiDataList>.from(json["csiDataList"]!.map((x) => CsiDataList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "csiDataList": csiDataList == null ? [] : List<dynamic>.from(csiDataList!.map((x) => x.toJson())),
  };
}

class CsiDataList {
  final String? checkNumber;
  final String? accountNumber;
  final String? collectionDate;
  final String? amount;
  final String? payee;
  final String? branch;
  final String? referenceNo;
  final String? category;

  CsiDataList({
    this.checkNumber,
    this.accountNumber,
    this.collectionDate,
    this.amount,
    this.payee,
    this.branch,
    this.referenceNo,
    this.category,
  });

  factory CsiDataList.fromJson(Map<String, dynamic> json) => CsiDataList(
    checkNumber: json["checkNumber"],
    accountNumber: json["accountNumber"],
    collectionDate: json["collectionDate"],
    amount: json["amount"],
    payee: json["payee"],
    branch: json["branch"],
    referenceNo: json["referenceNo"],
    category: json["category"],
  );

  Map<String, dynamic> toJson() => {
    "checkNumber": checkNumber,
    "accountNumber": accountNumber,
    "collectionDate": collectionDate,
    "amount": amount,
    "payee": payee,
    "branch": branch,
    "referenceNo": referenceNo,
    "category": category,
  };
}
