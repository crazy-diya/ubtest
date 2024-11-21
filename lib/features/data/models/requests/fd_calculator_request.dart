// To parse this JSON data, do
//
//     final fdCalculatorRequest = fdCalculatorRequestFromJson(jsonString);

import 'dart:convert';

FdCalculatorRequest fdCalculatorRequestFromJson(String str) => FdCalculatorRequest.fromJson(json.decode(str));

String fdCalculatorRequestToJson(FdCalculatorRequest data) => json.encode(data.toJson());

class FdCalculatorRequest {
  final String? messageType;
  final String? currencyCode;
  final String? amount;
  final String? interestPeriod;
  final String? interestReceived;
  final String? rate;

  FdCalculatorRequest({
    this.messageType,
    this.currencyCode,
    this.amount,
    this.interestPeriod,
    this.interestReceived,
    this.rate,
  });

  factory FdCalculatorRequest.fromJson(Map<String, dynamic> json) => FdCalculatorRequest(
    messageType: json["messageType"],
    currencyCode: json["currencyCode"],
    amount: json["amount"],
    interestPeriod: json["interestPeriod"],
    interestReceived: json["interestReceived"],
    rate: json["rate"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "currencyCode": currencyCode,
    "amount": amount,
    "interestPeriod": interestPeriod,
    "interestReceived": interestReceived,
    "rate": rate,
  };
}
