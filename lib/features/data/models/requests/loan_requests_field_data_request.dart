// To parse this JSON data, do
//
//     final loanRequestsFieldDataRequest = loanRequestsFieldDataRequestFromJson(jsonString);

import 'dart:convert';

LoanRequestsFieldDataRequest loanRequestsFieldDataRequestFromJson(String str) => LoanRequestsFieldDataRequest.fromJson(json.decode(str));

String loanRequestsFieldDataRequestToJson(LoanRequestsFieldDataRequest data) => json.encode(data.toJson());

class LoanRequestsFieldDataRequest {
  LoanRequestsFieldDataRequest({
    this.messageType,
  });

  String? messageType;

  factory LoanRequestsFieldDataRequest.fromJson(Map<String, dynamic> json) => LoanRequestsFieldDataRequest(
    messageType: json["messageType"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
  };
}
