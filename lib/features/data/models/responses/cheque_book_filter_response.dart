// To parse this JSON data, do
//
//     final chequeBookFilterResponse = chequeBookFilterResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

ChequeBookFilterResponse chequeBookFilterResponseFromJson(String str) => ChequeBookFilterResponse.fromJson(json.decode(str));

String chequeBookFilterResponseToJson(ChequeBookFilterResponse data) => json.encode(data.toJson());

class ChequeBookFilterResponse extends Serializable{
  final List<ChequeBookList>? chequeBookList;

  ChequeBookFilterResponse({
    this.chequeBookList,
  });

  factory ChequeBookFilterResponse.fromJson(Map<String, dynamic> json) => ChequeBookFilterResponse(
    chequeBookList: json["chequeBookList"] == null ? [] : List<ChequeBookList>.from(json["chequeBookList"]!.map((x) => ChequeBookList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "chequeBookList": chequeBookList == null ? [] : List<dynamic>.from(chequeBookList!.map((x) => x.toJson())),
  };
}

class ChequeBookList {
  final int? id;
  final String? accountNo;
  final String? collectionMethod;
  final String? branch;
  final String? address;
  final String? status;
  final int? numberOfLeaves;
  final int? serviceCharge;
  final int? deliveryCharge;
  final DateTime? modifiedDate;

  ChequeBookList({
    this.id,
    this.accountNo,
    this.collectionMethod,
    this.branch,
    this.address,
    this.status,
    this.numberOfLeaves,
    this.serviceCharge,
    this.deliveryCharge,
    this.modifiedDate,
  });

  factory ChequeBookList.fromJson(Map<String, dynamic> json) => ChequeBookList(
    id: json["id"],
    accountNo: json["accountNo"],
    collectionMethod: json["collectionMethod"],
    branch: json["branch"],
    address: json["address"],
    status: json["status"],
    numberOfLeaves: json["numberOfLeaves"],
    serviceCharge: json["serviceCharge"],
    deliveryCharge: json["deliveryCharge"],
    modifiedDate: json["modifiedDate"] == null ? null : DateTime.parse(json["modifiedDate"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "accountNo": accountNo,
    "collectionMethod": collectionMethod,
    "branch": branch,
    "address": address,
    "status": status,
    "numberOfLeaves": numberOfLeaves,
    "serviceCharge": serviceCharge,
    "deliveryCharge": deliveryCharge,
    "modifiedDate": modifiedDate?.toIso8601String(),
  };
}
