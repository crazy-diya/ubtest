// To parse this JSON data, do
//
//     final requestMoneyHistoryRequest = requestMoneyHistoryRequestFromJson(jsonString);

import 'dart:convert';

RequestMoneyHistoryRequest requestMoneyHistoryRequestFromJson(String str) => RequestMoneyHistoryRequest.fromJson(json.decode(str));

String requestMoneyHistoryRequestToJson(RequestMoneyHistoryRequest data) => json.encode(data.toJson());

class RequestMoneyHistoryRequest {
  final String? messageType;

  RequestMoneyHistoryRequest({
    this.messageType,
  });

  factory RequestMoneyHistoryRequest.fromJson(Map<String, dynamic> json) => RequestMoneyHistoryRequest(
    messageType: json["messageType"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
  };
}
