// To parse this JSON data, do
//
//     final goldLoanListRequest = goldLoanListRequestFromJson(jsonString);

import 'dart:convert';

GoldLoanListRequest goldLoanListRequestFromJson(String str) => GoldLoanListRequest.fromJson(json.decode(str));

String goldLoanListRequestToJson(GoldLoanListRequest data) => json.encode(data.toJson());

class GoldLoanListRequest {
  GoldLoanListRequest({
    this.messageType,
    this.nic,
    this.module,
  });

  String? messageType;
  String? nic;
  String? module;

  factory GoldLoanListRequest.fromJson(Map<String, dynamic> json) => GoldLoanListRequest(
    messageType: json["messageType"],
    nic: json["nic"],
    module: json["module"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "nic": nic,
    "module": module,
  };
}
