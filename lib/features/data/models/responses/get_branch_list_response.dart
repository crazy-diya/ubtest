// To parse this JSON data, do
//
//     final getBranchListResponse = getBranchListResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

GetBranchListResponse getBranchListResponseFromJson(String str) => GetBranchListResponse.fromJson(json.decode(str));

String getBranchListResponseToJson(GetBranchListResponse data) => json.encode(data.toJson());

class GetBranchListResponse extends Serializable{
  GetBranchListResponse({
    this.bankCode,
    this.bankName,
    this.bankBranchList,
  });

  String? bankCode;
  String? bankName;
  List<BankBranchList>? bankBranchList;

  factory GetBranchListResponse.fromJson(Map<String, dynamic> json) => GetBranchListResponse(
    bankCode: json["bankCode"],
    bankName: json["bankName"],
    bankBranchList: List<BankBranchList>.from(json["bankBranchList"].map((x) => BankBranchList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "bankCode": bankCode,
    "bankName": bankName,
    "bankBranchList": List<dynamic>.from(bankBranchList!.map((x) => x.toJson())),
  };
}

class BankBranchList {
  BankBranchList({
    this.bankCode,
    this.branchCode,
    this.branchName,
  });

  String? bankCode;
  String? branchCode;
  String? branchName;

  factory BankBranchList.fromJson(Map<String, dynamic> json) => BankBranchList(
    bankCode: json["bankCode"],
    branchCode: json["branchCode"],
    branchName: json["branchName"],
  );

  Map<String, dynamic> toJson() => {
    "bankCode": bankCode,
    "branchCode": branchCode,
    "branchName": branchName,
  };
}
