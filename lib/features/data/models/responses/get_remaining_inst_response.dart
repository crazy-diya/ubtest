// To parse this JSON data, do
//
//     final getRemainingInstResponse = getRemainingInstResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

GetRemainingInstResponse getRemainingInstResponseFromJson(String str) => GetRemainingInstResponse.fromJson(json.decode(str));

String getRemainingInstResponseToJson(GetRemainingInstResponse data) => json.encode(data.toJson());

class GetRemainingInstResponse extends Serializable {
  GetRemainingInstResponse({
    this.remainingAccountList,
  });

  List<RemainingAccountList>? remainingAccountList;

  factory GetRemainingInstResponse.fromJson(Map<String, dynamic> json) => GetRemainingInstResponse(
    remainingAccountList: List<RemainingAccountList>.from(json["remainingAccountList"].map((x) => RemainingAccountList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "remainingAccountList": List<dynamic>.from(remainingAccountList!.map((x) => x.toJson())),
  };
}

class RemainingAccountList {
  RemainingAccountList({
    this.accountNumber,
    this.accountHolderName,
    this.accBalance,
    this.productCode,
    this.currency,
    this.status,
    this.productName,
  });

  String? accountNumber;
  String? accountHolderName;
  String? accBalance;
  String? productCode;
  String? productName;
  String? currency;
  String? status;

  factory RemainingAccountList.fromJson(Map<String, dynamic> json) => RemainingAccountList(
    accountNumber: json["accountNumber"],
    accountHolderName: json["accountHolderName"],
    accBalance: json["accBalance"],
    productCode: json["productCode"],
    currency: json["currency"],
    status: json["status"],
    productName: json["productName"],
  );

  Map<String, dynamic> toJson() => {
    "accountNumber": accountNumber,
    "accountHolderName": accountHolderName,
    "accBalance": accBalance,
    "productCode": productCode,
    "currency": currency,
    "status": status,
    "productName": productName,
  };
}
