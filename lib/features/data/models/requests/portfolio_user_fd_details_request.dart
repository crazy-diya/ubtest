// To parse this JSON data, do
//
//     final portfolioUserFdDetailsRequest = portfolioUserFdDetailsRequestFromJson(jsonString);

import 'dart:convert';

PortfolioUserFdDetailsRequest portfolioUserFdDetailsRequestFromJson(String str) => PortfolioUserFdDetailsRequest.fromJson(json.decode(str));

String portfolioUserFdDetailsRequestToJson(PortfolioUserFdDetailsRequest data) => json.encode(data.toJson());

class PortfolioUserFdDetailsRequest {
  String? messageType;

  PortfolioUserFdDetailsRequest({
    required this.messageType,
  });

  factory PortfolioUserFdDetailsRequest.fromJson(Map<String, dynamic> json) => PortfolioUserFdDetailsRequest(
    messageType: json["messageType"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
  };
}
