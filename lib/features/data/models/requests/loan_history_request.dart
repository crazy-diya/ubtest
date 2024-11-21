// To parse this JSON data, do
//
//     final loanHistoryrequest = loanHistoryrequestFromJson(jsonString);

import 'dart:convert';

LoanHistoryrequest loanHistoryrequestFromJson(String str) => LoanHistoryrequest.fromJson(json.decode(str));

String loanHistoryrequestToJson(LoanHistoryrequest data) => json.encode(data.toJson());

class LoanHistoryrequest {
  String messageType;
  int page;
  int size;
  String accountNo;

  LoanHistoryrequest({
    required this.messageType,
    required this.page,
    required this.size,
    required this.accountNo,
  });

  factory LoanHistoryrequest.fromJson(Map<String, dynamic> json) => LoanHistoryrequest(
    messageType: json["messageType"],
    page: json["page"],
    size: json["size"],
    accountNo: json["accountNo"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "page": page,
    "size": size,
    "accountNo": accountNo,
  };
}
