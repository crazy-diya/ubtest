// To parse this JSON data, do
//
//     final requestMoneyResponse = requestMoneyResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

RequestMoneyResponse requestMoneyResponseFromJson(String str) => RequestMoneyResponse.fromJson(json.decode(str));

String requestMoneyResponseToJson(RequestMoneyResponse data) => json.encode(data.toJson());

class RequestMoneyResponse extends Serializable{
  final String? epicUserId;

  RequestMoneyResponse({
    this.epicUserId,
  });

  factory RequestMoneyResponse.fromJson(Map<String, dynamic> json) => RequestMoneyResponse(
    epicUserId: json["epicUserId"],
  );

  Map<String, dynamic> toJson() => {
    "epicUserId": epicUserId,
  };
}
