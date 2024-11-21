// To parse this JSON data, do
//
//     final getTxnCategoryRequest = getTxnCategoryRequestFromJson(jsonString);

import 'dart:convert';

GetTxnCategoryRequest getTxnCategoryRequestFromJson(String str) => GetTxnCategoryRequest.fromJson(json.decode(str));

String getTxnCategoryRequestToJson(GetTxnCategoryRequest data) => json.encode(data.toJson());

class GetTxnCategoryRequest {
  String? messageType;
  String? channelType;

  GetTxnCategoryRequest({
    this.messageType,
    this.channelType,
  });

  factory GetTxnCategoryRequest.fromJson(Map<String, dynamic> json) => GetTxnCategoryRequest(
    messageType: json["messageType"],
    channelType: json["channelType"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "channelType": channelType,
  };
}
