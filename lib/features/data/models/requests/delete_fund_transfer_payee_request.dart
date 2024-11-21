// To parse this JSON data, do
//
//     final deleteFundTransferPayeeRequest = deleteFundTransferPayeeRequestFromJson(jsonString);

import 'dart:convert';

DeleteFundTransferPayeeRequest deleteFundTransferPayeeRequestFromJson(String str) => DeleteFundTransferPayeeRequest.fromJson(json.decode(str));

String deleteFundTransferPayeeRequestToJson(DeleteFundTransferPayeeRequest data) => json.encode(data.toJson());

class DeleteFundTransferPayeeRequest {
  DeleteFundTransferPayeeRequest({
    this.messageType,
    this.accountNumberList,
  });

  String? messageType;
  List<String>? accountNumberList;

  factory DeleteFundTransferPayeeRequest.fromJson(Map<String, dynamic> json) => DeleteFundTransferPayeeRequest(
    messageType: json["messageType"],
    accountNumberList: List<String>.from(json["accountNumberList"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "accountNumberList": List<dynamic>.from(accountNumberList!.map((x) => x)),
  };
}
