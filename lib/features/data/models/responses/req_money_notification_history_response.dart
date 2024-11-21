// To parse this JSON data, do
//
//     final reqMoneyNotificationHistoryResponse = reqMoneyNotificationHistoryResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

ReqMoneyNotificationHistoryResponse reqMoneyNotificationHistoryResponseFromJson(String str) => ReqMoneyNotificationHistoryResponse.fromJson(json.decode(str));

String reqMoneyNotificationHistoryResponseToJson(ReqMoneyNotificationHistoryResponse data) => json.encode(data.toJson());

class ReqMoneyNotificationHistoryResponse extends Serializable{
  final String? requestMoneyId;
  final String? description;

  ReqMoneyNotificationHistoryResponse({
    this.requestMoneyId,
    this.description,
  });

  factory ReqMoneyNotificationHistoryResponse.fromJson(Map<String, dynamic> json) => ReqMoneyNotificationHistoryResponse(
    requestMoneyId: json["requestMoneyId"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "requestMoneyId": requestMoneyId,
    "description": description,
  };
}
