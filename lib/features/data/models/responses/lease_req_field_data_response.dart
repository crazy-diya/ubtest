// To parse this JSON data, do
//
//     final leaseReqFieldDataResponse = leaseReqFieldDataResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

LeaseReqFieldDataResponse leaseReqFieldDataResponseFromJson(String str) => LeaseReqFieldDataResponse.fromJson(json.decode(str));

String leaseReqFieldDataResponseToJson(LeaseReqFieldDataResponse data) => json.encode(data.toJson());

class LeaseReqFieldDataResponse extends Serializable {
  LeaseReqFieldDataResponse({
    this.addressLine1,
    this.addressLine2,
    this.addressLine3,
    this.title,
    this.firstName,
    this.lastName,
    this.nic,
    this.mobileNo,
    this.gender,
    this.maritalStatus,
    this.designation,
    this.empType,
    this.leaseTypeTenorDataDtoList,
  });

  String? addressLine1;
  String? addressLine2;
  String? addressLine3;
  String? title;
  String? firstName;
  String? lastName;
  String? nic;
  String? mobileNo;
  String? gender;
  String? maritalStatus;
  String? designation;
  String? empType;
  List<LeaseTypeTenorDataDtoList>? leaseTypeTenorDataDtoList;

  factory LeaseReqFieldDataResponse.fromJson(Map<String, dynamic> json) => LeaseReqFieldDataResponse(
    addressLine1: json["addressLine1"],
    addressLine2: json["addressLine2"],
    addressLine3: json["addressLine3"],
    title: json["title"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    nic: json["nic"],
    mobileNo: json["mobileNo"],
    gender: json["gender"],
    maritalStatus: json["maritalStatus"],
    designation: json["designation"],
    empType: json["empType"],
    leaseTypeTenorDataDtoList: List<LeaseTypeTenorDataDtoList>.from(json["leaseTypeTenorDataDTOList"].map((x) => LeaseTypeTenorDataDtoList.fromJson(x))),
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
    "gender": gender,
    "maritalStatus": maritalStatus,
    "designation": designation,
    "empType": empType,
    "leaseTypeTenorDataDTOList": List<dynamic>.from(leaseTypeTenorDataDtoList!.map((x) => x.toJson())),
  };
}


class LeaseTypeTenorDataDtoList {
  LeaseTypeTenorDataDtoList({
    this.typeId,
    this.leaseName,
    this.tenorData,
  });

  int? typeId;
  String? leaseName;
  List<TenorDatum>? tenorData;

  factory LeaseTypeTenorDataDtoList.fromJson(Map<String, dynamic> json) => LeaseTypeTenorDataDtoList(
    typeId: json["typeId"],
    leaseName: json["leaseName"],
    tenorData: List<TenorDatum>.from(json["tenorData"].map((x) => TenorDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "typeId": typeId,
    "leaseName": leaseName,
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
