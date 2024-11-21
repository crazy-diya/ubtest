// To parse this JSON data, do
//
//     final getCurrencyListRequest = getCurrencyListRequestFromJson(jsonString);

import 'dart:convert';

GetCurrencyListRequest getCurrencyListRequestFromJson(String str) => GetCurrencyListRequest.fromJson(json.decode(str));

String getCurrencyListRequestToJson(GetCurrencyListRequest data) => json.encode(data.toJson());

class GetCurrencyListRequest {
  String? messageType;

  GetCurrencyListRequest({
    this.messageType,
  });

  factory GetCurrencyListRequest.fromJson(Map<String, dynamic> json) => GetCurrencyListRequest(
    messageType: json["messageType"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
  };
}
