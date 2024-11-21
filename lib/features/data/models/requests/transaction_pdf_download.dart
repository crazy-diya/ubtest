// To parse this JSON data, do
//
//     final transactionStatusPdfRequest = transactionStatusPdfRequestFromJson(jsonString);

import 'dart:convert';

TransactionStatusPdfRequest transactionStatusPdfRequestFromJson(String str) => TransactionStatusPdfRequest.fromJson(json.decode(str));

String transactionStatusPdfRequestToJson(TransactionStatusPdfRequest data) => json.encode(data.toJson());

class TransactionStatusPdfRequest {
  String? transactionId;
  String? messageType;


  TransactionStatusPdfRequest({
     this.transactionId,
     this.messageType,


  });

  factory TransactionStatusPdfRequest.fromJson(Map<String, dynamic> json) => TransactionStatusPdfRequest(
    transactionId: json["transactionId"],
    messageType: json["messageType"],

  );

  Map<String, dynamic> toJson() => {
    "transactionId": transactionId,
    "messageType": messageType,

  };
}
