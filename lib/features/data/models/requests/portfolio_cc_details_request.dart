// To parse this JSON data, do
//
//     final portfolioCcDetailsRequest = portfolioCcDetailsRequestFromJson(jsonString);

import 'dart:convert';

PortfolioCcDetailsRequest portfolioCcDetailsRequestFromJson(String str) => PortfolioCcDetailsRequest.fromJson(json.decode(str));

String portfolioCcDetailsRequestToJson(PortfolioCcDetailsRequest data) => json.encode(data.toJson());

class PortfolioCcDetailsRequest {
  String? messageType;

  PortfolioCcDetailsRequest({
    this.messageType,
  });

  factory PortfolioCcDetailsRequest.fromJson(Map<String, dynamic> json) => PortfolioCcDetailsRequest(
    messageType: json["messageType"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
  };
}
