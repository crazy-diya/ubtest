// To parse this JSON data, do
//
//     final getMoneyNotificationResponse = getMoneyNotificationResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

GetMoneyNotificationResponse getMoneyNotificationResponseFromJson(String str) => GetMoneyNotificationResponse.fromJson(json.decode(str));

String getMoneyNotificationResponseToJson(GetMoneyNotificationResponse data) => json.encode(data.toJson());

class GetMoneyNotificationResponse extends Serializable{
  final int? id;
  final String? toAccount;
  final String? toAccountName;
  final String? toBankCode;
  final num? requestedAmount;
  final DateTime? requestedDate;

  GetMoneyNotificationResponse({
    this.id,
    this.toAccount,
    this.toAccountName,
    this.toBankCode,
    this.requestedAmount,
    this.requestedDate,
  });

  factory GetMoneyNotificationResponse.fromJson(Map<String, dynamic> json) => GetMoneyNotificationResponse(
    id: json["id"],
    toAccount: json["toAccount"],
    toBankCode: json["toBankCode"],
    toAccountName: json["toAccountName"],
    requestedAmount: json["requestedAmount"],
    requestedDate: json["requestedDate"] == null ? null : DateTime.parse(json["requestedDate"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "toAccount": toAccount,
    "toBankCode": toBankCode,
    "toAccountName": toAccountName,
    "requestedAmount": requestedAmount,
    "requestedDate": requestedDate?.toIso8601String(),
  };
}
