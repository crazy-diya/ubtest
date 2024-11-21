// To parse this JSON data, do
//
//     final loanHistoryPdfRequest = loanHistoryPdfRequestFromJson(jsonString);

import 'dart:convert';

LoanHistoryPdfRequest loanHistoryPdfRequestFromJson(String str) => LoanHistoryPdfRequest.fromJson(json.decode(str));

String loanHistoryPdfRequestToJson(LoanHistoryPdfRequest data) => json.encode(data.toJson());

class LoanHistoryPdfRequest {
  String messageType;
  String? accountNo;

  LoanHistoryPdfRequest({
    required this.messageType,
     this.accountNo,
  });

  factory LoanHistoryPdfRequest.fromJson(Map<String, dynamic> json) => LoanHistoryPdfRequest(
    messageType: json["messageType"],
    accountNo: json["accountNo"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "accountNo": accountNo,
  };
}
