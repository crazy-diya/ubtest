
import 'dart:convert';


AddPayRequest addPayRequestFromJson(String str) => AddPayRequest.fromJson(json.decode(str));

String addPayRequestToJson(AddPayRequest data) => json.encode(data.toJson());

class AddPayRequest  {
  AddPayRequest({
    this.messageType,
    this.accountNumber,
    this.nickName,
    this.bankCode,
    this.name,
    this.favourite,
    this.branchId,
    this.verified

  });

  String? messageType;
  String? accountNumber;
  String? nickName;
  String? bankCode;
  String? branchId;
  String? name;
  bool? favourite;
  bool? verified;

  factory AddPayRequest.fromJson(Map<String, dynamic> json) => AddPayRequest(
    messageType: json["messageType"],
    accountNumber: json["accountNumber"],
    nickName: json["nickName"],
    bankCode: json["bankCode"],
    branchId: json["branchId"],
    name: json["name"],
    favourite: json["favourite"],
    verified: json["verified"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "accountNumber": accountNumber,
    "nickName": nickName,
    "bankCode": bankCode,
    "branchId": branchId,
    "name": name,
    "favourite": favourite,
    "verified": verified,
  };
}
