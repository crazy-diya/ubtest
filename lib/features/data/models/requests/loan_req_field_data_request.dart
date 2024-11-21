// To parse this JSON data, do
//
//     final loanReqFieldDataRequest = loanReqFieldDataRequestFromJson(jsonString);

import 'dart:convert';

LoanReqFieldDataRequest loanReqFieldDataRequestFromJson(String str) => LoanReqFieldDataRequest.fromJson(json.decode(str));

String loanReqFieldDataRequestToJson(LoanReqFieldDataRequest data) => json.encode(data.toJson());

class LoanReqFieldDataRequest {
  LoanReqFieldDataRequest({
    this.messageType,
  });

  String? messageType;

  factory LoanReqFieldDataRequest.fromJson(Map<String, dynamic> json) => LoanReqFieldDataRequest(
    messageType: json["messageType"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
  };
}
