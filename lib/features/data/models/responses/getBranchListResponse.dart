// To parse this JSON data, do
//
//     final getBankBranchListResponse = getBankBranchListResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

GetBankBranchListResponse getBankBranchListResponseFromJson(String str) => GetBankBranchListResponse.fromJson(json.decode(str));

String getBankBranchListResponseToJson(GetBankBranchListResponse data) => json.encode(data.toJson());

class GetBankBranchListResponse extends Serializable{
  List<BranchList>? branchList;
  int? count;

  GetBankBranchListResponse({
    this.branchList,
    this.count,
  });

  factory GetBankBranchListResponse.fromJson(Map<String, dynamic> json) => GetBankBranchListResponse(
    branchList: List<BranchList>.from(json["branchList"].map((x) => BranchList.fromJson(x))),
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "branchList": List<dynamic>.from(branchList!.map((x) => x.toJson())),
    "count": count,
  };
}

class BranchList {
  String? branchCode;
  String? branchName;

  BranchList({
    this.branchCode,
    this.branchName,
  });

  factory BranchList.fromJson(Map<String, dynamic> json) => BranchList(
    branchCode: json["branchCode"],
    branchName: json["branchName"],
  );

  Map<String, dynamic> toJson() => {
    "branchCode": branchCode,
    "branchName": branchName,
  };
}
