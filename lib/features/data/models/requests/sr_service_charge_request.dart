// To parse this JSON data, do
//
//     final srServiceChargeRequest = srServiceChargeRequestFromJson(jsonString);

import 'dart:convert';

SrServiceChargeRequest srServiceChargeRequestFromJson(String str) => SrServiceChargeRequest.fromJson(json.decode(str));

String srServiceChargeRequestToJson(SrServiceChargeRequest data) => json.encode(data.toJson());

class SrServiceChargeRequest {
  final String? messageType;

  SrServiceChargeRequest({
    this.messageType,
  });

  factory SrServiceChargeRequest.fromJson(Map<String, dynamic> json) => SrServiceChargeRequest(
    messageType: json["messageType"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
  };
}
