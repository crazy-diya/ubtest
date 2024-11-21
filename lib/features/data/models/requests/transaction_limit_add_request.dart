// To parse this JSON data, do
//
//     final transactionLimitAddRequest = transactionLimitAddRequestFromJson(jsonString);

import 'dart:convert';

TransactionLimitAddRequest transactionLimitAddRequestFromJson(String str) =>
    TransactionLimitAddRequest.fromJson(json.decode(str));

String transactionLimitAddRequestToJson(TransactionLimitAddRequest data) =>
    json.encode(data.toJson());

class TransactionLimitAddRequest {
  TransactionLimitAddRequest({
    this.messageType,
    this.channelType,
    this.code,
    this.maxAmountPerDay,
  });

  String? messageType;
  String? channelType;
  String? code;
  double? maxAmountPerDay;

  factory TransactionLimitAddRequest.fromJson(Map<String, dynamic> json) =>
      TransactionLimitAddRequest(
        messageType: json["messageType"],
        channelType: json["channelType"],
        code: json["code"],
        maxAmountPerDay: json["maxAmountPerDay"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "messageType": messageType,
        "channelType": channelType,
        "code": code,
        "maxAmountPerDay": maxAmountPerDay,
      };
}
