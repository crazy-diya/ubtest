// To parse this JSON data, do
//
//     final goldLoanDetailsRequest = goldLoanDetailsRequestFromJson(jsonString);

import 'dart:convert';

GoldLoanDetailsRequest goldLoanDetailsRequestFromJson(String str) =>
    GoldLoanDetailsRequest.fromJson(json.decode(str));

String goldLoanDetailsRequestToJson(GoldLoanDetailsRequest data) =>
    json.encode(data.toJson());

class GoldLoanDetailsRequest {
  GoldLoanDetailsRequest({
    this.messageType,
    this.referenceNo,
    this.module,
  });

  String? messageType;
  String? referenceNo;
  String? module;

  factory GoldLoanDetailsRequest.fromJson(Map<String, dynamic> json) =>
      GoldLoanDetailsRequest(
        messageType: json["messageType"],
        referenceNo: json["referenceNo"],
        module: json["module"],
      );

  Map<String, dynamic> toJson() => {
        "messageType": messageType,
        "referenceNo": referenceNo,
        "module": module,
      };
}
