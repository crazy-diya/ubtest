// To parse this JSON data, do
//
//     final txnLimitResetRequest = txnLimitResetRequestFromJson(jsonString);

import 'dart:convert';

TxnLimitResetRequest txnLimitResetRequestFromJson(String str) => TxnLimitResetRequest.fromJson(json.decode(str));

String txnLimitResetRequestToJson(TxnLimitResetRequest data) => json.encode(data.toJson());

class TxnLimitResetRequest {
  final String? messageType;

  TxnLimitResetRequest({
    this.messageType,
  });

  factory TxnLimitResetRequest.fromJson(Map<String, dynamic> json) => TxnLimitResetRequest(
    messageType: json["messageType"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
  };
}
