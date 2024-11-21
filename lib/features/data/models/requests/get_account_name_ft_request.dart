// To parse this JSON data, do
//
//     final getAcctNameFtRequest = getAcctNameFtRequestFromJson(jsonString);

import 'dart:convert';

GetAcctNameFtRequest getAcctNameFtRequestFromJson(String str) => GetAcctNameFtRequest.fromJson(json.decode(str));

String getAcctNameFtRequestToJson(GetAcctNameFtRequest data) => json.encode(data.toJson());

class GetAcctNameFtRequest {
  final String? messageType;
  final String? accountNo;

  GetAcctNameFtRequest({
    this.messageType,
    this.accountNo,
  });

  factory GetAcctNameFtRequest.fromJson(Map<String, dynamic> json) => GetAcctNameFtRequest(
    messageType: json["messageType"],
    accountNo: json["accountNumber"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "accountNumber": accountNo,
  };
}
