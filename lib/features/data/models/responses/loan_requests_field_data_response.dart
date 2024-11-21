// To parse this JSON data, do
//
//     final loanRequestFieldDataResponse = loanRequestFieldDataResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

LoanRequestFieldDataResponse loanRequestFieldDataResponseFromJson(String str) => LoanRequestFieldDataResponse.fromJson(json.decode(str));

String loanRequestFieldDataResponseToJson(LoanRequestFieldDataResponse data) => json.encode(data.toJson());

class LoanRequestFieldDataResponse extends Serializable {
  LoanRequestFieldDataResponse({
    this.addressLine1,
    this.addressLine2,
    this.addressLine3,
    this.title,
    this.firstName,
    this.lastName,
    this.nic,
    this.mobileNo,
    this.loanTypesTenor,
    this.maritalStatus,
    this.gender,
    this.empType,
  });

  String? addressLine1;
  String? addressLine2;
  String? addressLine3;
  String? title;
  String? firstName;
  String? lastName;
  String? nic;
  String? mobileNo;
  List<LoanTypesTenor>? loanTypesTenor;
  String? maritalStatus;
  String? gender;
  String? empType;

  factory LoanRequestFieldDataResponse.fromJson(Map<String, dynamic> json) => LoanRequestFieldDataResponse(
    addressLine1: json["addressLine1"],
    addressLine2: json["addressLine2"],
    addressLine3: json["addressLine3"],
    title: json["title"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    nic: json["nic"],
    mobileNo: json["mobileNo"],
    loanTypesTenor: List<LoanTypesTenor>.from(json["loanTypesTenor"].map((x) => LoanTypesTenor.fromJson(x))),
    maritalStatus: json["maritalStatus"],
    gender: json["gender"],
    empType: json["empType"],
  );

  Map<String, dynamic> toJson() => {
    "addressLine1": addressLine1,
    "addressLine2": addressLine2,
    "addressLine3": addressLine3,
    "title": title,
    "firstName": firstName,
    "lastName": lastName,
    "nic": nic,
    "mobileNo": mobileNo,
    "loanTypesTenor": List<dynamic>.from(loanTypesTenor!.map((x) => x.toJson())),
    "maritalStatus": maritalStatus,
    "gender": gender,
    "empType": empType,
  };
}

class LoanTypesTenor {
  LoanTypesTenor({
    this.typeId,
    this.loanName,
    this.tenorData,
  });

  int? typeId;
  String? loanName;
  List<TenorDatum>? tenorData;

  factory LoanTypesTenor.fromJson(Map<String, dynamic> json) => LoanTypesTenor(
    typeId: json["typeId"],
    loanName: json["loanName"],
    tenorData: List<TenorDatum>.from(json["tenorData"].map((x) => TenorDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "typeId": typeId,
    "loanName": loanName,
    "tenorData": List<dynamic>.from(tenorData!.map((x) => x.toJson())),
  };
}

class TenorDatum {
  TenorDatum({
    this.tenorId,
    this.tenor,
  });

  int? tenorId;
  int? tenor;

  factory TenorDatum.fromJson(Map<String, dynamic> json) => TenorDatum(
    tenorId: json["tenorId"],
    tenor: json["tenor"],
  );

  Map<String, dynamic> toJson() => {
    "tenorId": tenorId,
    "tenor": tenor,
  };
}
