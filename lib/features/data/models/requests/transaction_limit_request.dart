// To parse this JSON data, do
//
//     final transactionLimitRequest = transactionLimitRequestFromJson(jsonString);

import 'dart:convert';

TransactionLimitRequest transactionLimitRequestFromJson(String str) =>
    TransactionLimitRequest.fromJson(json.decode(str));

String transactionLimitRequestToJson(TransactionLimitRequest data) =>
    json.encode(data.toJson());

class TransactionLimitRequest {
  TransactionLimitRequest({
    this.messageType,
    this.channelType,
  });

  String? messageType;
  String? channelType;

  factory TransactionLimitRequest.fromJson(Map<String, dynamic> json) =>
      TransactionLimitRequest(
        messageType: json["messageType"],
        channelType: json["channelType"],
      );

  Map<String, dynamic> toJson() => {
        "messageType": messageType,
        "channelType": channelType,
      };
}
