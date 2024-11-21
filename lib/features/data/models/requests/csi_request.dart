// To parse this JSON data, do
//
//     final csiRequest = csiRequestFromJson(jsonString);

import 'dart:convert';

CsiRequest csiRequestFromJson(String str) => CsiRequest.fromJson(json.decode(str));

String csiRequestToJson(CsiRequest data) => json.encode(data.toJson());

class CsiRequest {
  final bool? checkAllAccount;
  final String? accountNo;
  final String? accountType;
  final DateTime? fromDate;
  final DateTime? toDate;

  CsiRequest({
    this.checkAllAccount,
    this.accountNo,
    this.accountType,
    this.fromDate,
    this.toDate,
  });

  factory CsiRequest.fromJson(Map<String, dynamic> json) => CsiRequest(
    checkAllAccount: json["checkAllAccount"],
    accountNo: json["accountNo"],
    accountType: json["accountType"],
    fromDate: json["fromDate"] == null ? null : DateTime.parse(json["fromDate"]),
    toDate: json["toDate"] == null ? null : DateTime.parse(json["toDate"]),
  );

  Map<String, dynamic> toJson() => {
    "checkAllAccount": checkAllAccount,
    "accountNo": accountNo,
    "accountType": accountType,
    "fromDate": fromDate?.toIso8601String(),
    "toDate": toDate?.toIso8601String(),
  };
}
