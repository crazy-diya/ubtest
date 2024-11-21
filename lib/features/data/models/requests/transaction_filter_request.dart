// To parse this JSON data, do
//
//     final transactionFilterRequest = transactionFilterRequestFromJson(jsonString);

import 'dart:convert';

TransactionFilterRequest transactionFilterRequestFromJson(String str) => TransactionFilterRequest.fromJson(json.decode(str));

String transactionFilterRequestToJson(TransactionFilterRequest data) => json.encode(data.toJson());

class TransactionFilterRequest {
  int? page;
  int? size;
  String? fromDate;
  String? toDate;
  double? fromAmount;
  double? toAmount;
  String? tranType;
  String? accountNo;
  String? channel;

  TransactionFilterRequest({
    this.page,
    this.size,
    this.fromDate,
    this.toDate,
    this.fromAmount,
    this.toAmount,
    this.tranType,
    this.accountNo,
    this.channel,
  });

  factory TransactionFilterRequest.fromJson(Map<String, dynamic> json) => TransactionFilterRequest(
    page: json["page"],
    size: json["size"],
    fromDate: json["fromDate"],
    toDate: json["toDate"],
    fromAmount: json["fromAmount"],
    toAmount: json["toAmount"],
    tranType: json["tranType"],
    accountNo: json["accountNo"],
    channel: json["channel"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "size": size,
    "fromDate": fromDate,
    "toDate": toDate,
    "fromAmount": fromAmount,
    "toAmount": toAmount,
    "tranType": tranType,
    "accountNo": accountNo,
    "channel": channel,
  };
}
