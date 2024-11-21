// To parse this JSON data, do
//
//     final debitCardReqFieldDataResponse = debitCardReqFieldDataResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

DebitCardReqFieldDataResponse debitCardReqFieldDataResponseFromJson(
        String str) =>
    DebitCardReqFieldDataResponse.fromJson(json.decode(str));

String debitCardReqFieldDataResponseToJson(
        DebitCardReqFieldDataResponse data) =>
    json.encode(data.toJson());

class DebitCardReqFieldDataResponse extends Serializable{
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

  DebitCardReqFieldDataResponse({
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
  });

  factory DebitCardReqFieldDataResponse.fromJson(Map<String, dynamic> json) =>
      DebitCardReqFieldDataResponse(
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
      };
}
