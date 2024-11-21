// To parse this JSON data, do
//
//     final getBankBranchListRequest = getBankBranchListRequestFromJson(jsonString);

import 'dart:convert';

GetBankBranchListRequest getBankBranchListRequestFromJson(String str) => GetBankBranchListRequest.fromJson(json.decode(str));

String getBankBranchListRequestToJson(GetBankBranchListRequest data) => json.encode(data.toJson());

class GetBankBranchListRequest {
  String? messageType;
  String? bankCode;

  GetBankBranchListRequest({
    this.messageType,
    this.bankCode,
  });

  factory GetBankBranchListRequest.fromJson(Map<String, dynamic> json) => GetBankBranchListRequest(
    messageType: json["messageType"],
    bankCode: json["bankCode"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "bankCode": bankCode,
  };
}
