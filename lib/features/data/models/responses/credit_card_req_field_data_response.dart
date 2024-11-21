// To parse this JSON data, do
//
//     final creditCardReqFieldDataResponse = creditCardReqFieldDataResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

CreditCardReqFieldDataResponse creditCardReqFieldDataResponseFromJson(String str) => CreditCardReqFieldDataResponse.fromJson(json.decode(str));

String creditCardReqFieldDataResponseToJson(CreditCardReqFieldDataResponse data) => json.encode(data.toJson());

class CreditCardReqFieldDataResponse extends Serializable {
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

  CreditCardReqFieldDataResponse({
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
  });

  factory CreditCardReqFieldDataResponse.fromJson(Map<String, dynamic> json) => CreditCardReqFieldDataResponse(
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
  );

  Map<String, dynamic> toJson() => {
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
  };
}
