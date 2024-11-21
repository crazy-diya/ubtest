// To parse this JSON data, do
//
//     final getAcctNameFtResponse = getAcctNameFtResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

GetAcctNameFtResponse getAcctNameFtResponseFromJson(String str) => GetAcctNameFtResponse.fromJson(json.decode(str));

String getAcctNameFtResponseToJson(GetAcctNameFtResponse data) => json.encode(data.toJson());

class GetAcctNameFtResponse extends Serializable{
  final String? accountName;

  GetAcctNameFtResponse({
    this.accountName,
  });

  factory GetAcctNameFtResponse.fromJson(Map<String, dynamic> json) => GetAcctNameFtResponse(
    accountName: json["accountName"],
  );

  Map<String, dynamic> toJson() => {
    "accountName": accountName,
  };
}
