// To parse this JSON data, do
//
//     final loanHistoryExcelRequest = loanHistoryExcelRequestFromJson(jsonString);

import 'dart:convert';

LoanHistoryExcelRequest loanHistoryExcelRequestFromJson(String str) => LoanHistoryExcelRequest.fromJson(json.decode(str));

String loanHistoryExcelRequestToJson(LoanHistoryExcelRequest data) => json.encode(data.toJson());

class LoanHistoryExcelRequest {
  String messageType;
  String loanNo;

  LoanHistoryExcelRequest({
    required this.messageType,
    required this.loanNo,
  });

  factory LoanHistoryExcelRequest.fromJson(Map<String, dynamic> json) => LoanHistoryExcelRequest(
    messageType: json["messageType"],
    loanNo: json["loanNo"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "loanNo": loanNo,
  };
}
