// To parse this JSON data, do
//
//     final portfolioLoanDetailsRequest = portfolioLoanDetailsRequestFromJson(jsonString);

import 'dart:convert';

PortfolioLoanDetailsRequest portfolioLoanDetailsRequestFromJson(String str) => PortfolioLoanDetailsRequest.fromJson(json.decode(str));

String portfolioLoanDetailsRequestToJson(PortfolioLoanDetailsRequest data) => json.encode(data.toJson());

class PortfolioLoanDetailsRequest {
  String messageType;

  PortfolioLoanDetailsRequest({
    required this.messageType,
  });

  factory PortfolioLoanDetailsRequest.fromJson(Map<String, dynamic> json) => PortfolioLoanDetailsRequest(
    messageType: json["messageType"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
  };
}
