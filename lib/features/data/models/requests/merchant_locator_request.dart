// To parse this JSON data, do
//
//     final merchantLocatorRequest = merchantLocatorRequestFromJson(jsonString);

import 'dart:convert';

MerchantLocatorRequest merchantLocatorRequestFromJson(String str) => MerchantLocatorRequest.fromJson(json.decode(str));

String merchantLocatorRequestToJson(MerchantLocatorRequest data) => json.encode(data.toJson());

class MerchantLocatorRequest {
  MerchantLocatorRequest({
    this.messageType,
  });

  String? messageType;

  factory MerchantLocatorRequest.fromJson(Map<String, dynamic> json) => MerchantLocatorRequest(
    messageType: json["messageType"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
  };
}
