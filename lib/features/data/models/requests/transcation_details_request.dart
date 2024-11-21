// To parse this JSON data, do
//
//     final transactionDetailsRequest = transactionDetailsRequestFromJson(jsonString);

import 'dart:convert';

TransactionDetailsRequest transactionDetailsRequestFromJson(String str) =>
    TransactionDetailsRequest.fromJson(json.decode(str));

String transactionDetailsRequestToJson(TransactionDetailsRequest data) =>
    json.encode(data.toJson());

class TransactionDetailsRequest {
  TransactionDetailsRequest({
    this.messageType,
    this.page,
    this.size,
  });

  String? messageType;
  int? page;
  int? size;

  factory TransactionDetailsRequest.fromJson(Map<String, dynamic> json) =>
      TransactionDetailsRequest(
        messageType: json["messageType"],
        page: json["page"],
        size: json["size"],
      );

  Map<String, dynamic> toJson() => {
        "messageType": messageType,
        "page": page,
        "size": size,
      };
}
