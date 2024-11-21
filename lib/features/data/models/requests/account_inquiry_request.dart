// To parse this JSON data, do
//
//     final accountInquiryRequest = accountInquiryRequestFromJson(jsonString);

import 'dart:convert';

AccountInquiryRequest accountInquiryRequestFromJson(String str) => AccountInquiryRequest.fromJson(json.decode(str));

String accountInquiryRequestToJson(AccountInquiryRequest data) => json.encode(data.toJson());

class AccountInquiryRequest {
  AccountInquiryRequest({
    this.messageType,
    this.cif,
  });

  String? messageType;
  String? cif;

  factory AccountInquiryRequest.fromJson(Map<String, dynamic> json) => AccountInquiryRequest(
    messageType: json["messageType"],
    cif: json["cif"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "cif": cif,
  };
}
