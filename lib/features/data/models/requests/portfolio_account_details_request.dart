// To parse this JSON data, do
//
//     final portfolioAccDetailsRequest = portfolioAccDetailsRequestFromJson(jsonString);

import 'dart:convert';

PortfolioAccDetailsRequest portfolioAccDetailsRequestFromJson(String str) => PortfolioAccDetailsRequest.fromJson(json.decode(str));

String portfolioAccDetailsRequestToJson(PortfolioAccDetailsRequest data) => json.encode(data.toJson());

class PortfolioAccDetailsRequest {
  String? messageType;

  PortfolioAccDetailsRequest({
    this.messageType,
  });

  factory PortfolioAccDetailsRequest.fromJson(Map<String, dynamic> json) => PortfolioAccDetailsRequest(
    messageType: json["messageType"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
  };
}
