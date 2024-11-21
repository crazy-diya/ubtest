// To parse this JSON data, do
//
//     final creditCardReqSaveRequest = creditCardReqSaveRequestFromJson(jsonString);

import 'dart:convert';

CreditCardReqSaveRequest creditCardReqSaveRequestFromJson(String str) => CreditCardReqSaveRequest.fromJson(json.decode(str));

String creditCardReqSaveRequestToJson(CreditCardReqSaveRequest data) => json.encode(data.toJson());

class CreditCardReqSaveRequest {
  String? messageType;
  String? title;
  String? firstName;
  String? lastName;
  String? addressLine1;
  String? addressLine2;
  String? addressLine3;
  String? maritalStatus;
  String? gender;
  String? nic;
  String? mobileNo;
  String? dob;
  String? embossingName;

  CreditCardReqSaveRequest({
    this.messageType,
    this.title,
    this.firstName,
    this.lastName,
    this.addressLine1,
    this.addressLine2,
    this.addressLine3,
    this.maritalStatus,
    this.gender,
    this.nic,
    this.mobileNo,
    this.dob,
    this.embossingName,
  });

  factory CreditCardReqSaveRequest.fromJson(Map<String, dynamic> json) => CreditCardReqSaveRequest(
    messageType: json["messageType"],
    title: json["title"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    addressLine1: json["addressLine1"],
    addressLine2: json["addressLine2"],
    addressLine3: json["addressLine3"],
    maritalStatus: json["maritalStatus"],
    gender: json["gender"],
    nic: json["nic"],
    mobileNo: json["mobileNo"],
    dob: json["dob"],
    embossingName: json["embossingName"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "title": title,
    "firstName": firstName,
    "lastName": lastName,
    "addressLine1": addressLine1,
    "addressLine2": addressLine2,
    "addressLine3": addressLine3,
    "maritalStatus": maritalStatus,
    "gender": gender,
    "nic": nic,
    "mobileNo": mobileNo,
    "dob": dob,
    "embossingName": embossingName,
  };
}
