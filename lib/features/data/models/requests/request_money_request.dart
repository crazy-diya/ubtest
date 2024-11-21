// To parse this JSON data, do
//
//     final requestMoneyRequest = requestMoneyRequestFromJson(jsonString);

import 'dart:convert';

RequestMoneyRequest requestMoneyRequestFromJson(String str) => RequestMoneyRequest.fromJson(json.decode(str));

String requestMoneyRequestToJson(RequestMoneyRequest data) => json.encode(data.toJson());

class RequestMoneyRequest {
  final String? messageType;
  final String? toAccountNumber;
  final String? mobileNumber;
  final String? requestedAmount;
  final String? remarks;

  RequestMoneyRequest({
    this.messageType,
    this.toAccountNumber,
    this.mobileNumber,
    this.requestedAmount,
    this.remarks,
  });

  factory RequestMoneyRequest.fromJson(Map<String, dynamic> json) => RequestMoneyRequest(
    messageType: json["messageType"],
    toAccountNumber: json["toAccountNumber"],
    mobileNumber: json["mobileNumber"],
    requestedAmount: json["requestedAmount"],
      remarks: json["remarks"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "toAccountNumber": toAccountNumber,
    "mobileNumber": mobileNumber,
    "requestedAmount": requestedAmount,
    "remarks": remarks,
  };
}
