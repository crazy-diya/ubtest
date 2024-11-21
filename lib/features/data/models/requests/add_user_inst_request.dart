// To parse this JSON data, do
//
//     final addUserInstRequest = addUserInstRequestFromJson(jsonString);

import 'dart:convert';

AddUserInstRequest addUserInstRequestFromJson(String str) => AddUserInstRequest.fromJson(json.decode(str));

String addUserInstRequestToJson(AddUserInstRequest data) => json.encode(data.toJson());

class AddUserInstRequest {
  AddUserInstRequest({
    this.messageType,
    this.accountNo,
  });

  String? messageType;
  String? accountNo;

  factory AddUserInstRequest.fromJson(Map<String, dynamic> json) => AddUserInstRequest(
    messageType: json["messageType"],
    accountNo: json["accountNo"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "accountNo": accountNo,
  };
}
