// To parse this JSON data, do
//
//     final debitCardSaveDataRequest = debitCardSaveDataRequestFromJson(jsonString);

import 'dart:convert';

DebitCardSaveDataRequest debitCardSaveDataRequestFromJson(String str) => DebitCardSaveDataRequest.fromJson(json.decode(str));

String debitCardSaveDataRequestToJson(DebitCardSaveDataRequest data) => json.encode(data.toJson());

class DebitCardSaveDataRequest {
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
  String? embossingName;
  String? mothersMaidenName;
  String? branchCode;
  int? instrumentId;

  DebitCardSaveDataRequest({
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
    this.embossingName,
    this.mothersMaidenName,
    this.branchCode,
    this.instrumentId
  });

  factory DebitCardSaveDataRequest.fromJson(Map<String, dynamic> json) => DebitCardSaveDataRequest(
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
    embossingName: json["embossingName"],
    mothersMaidenName: json["mothersMaidenName"],
    branchCode: json["branchCode"],
    instrumentId: json["instrumentId"],
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
    "embossingName": embossingName,
    "mothersMaidenName": mothersMaidenName,
    "branchCode": branchCode,
    "instrumentId": instrumentId,
  };
}
