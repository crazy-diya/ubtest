// To parse this JSON data, do
//
//     final client = clientFromJson(jsonString);

import 'dart:convert';

EmpDetailRequest empDetailRequestFromJson(String str) => EmpDetailRequest.fromJson(json.decode(str));

String empDetailRequestToJson(EmpDetailRequest data) => json.encode(data.toJson());

class EmpDetailRequest {
  EmpDetailRequest({
    this.messageType,
    this.isTaxPayerUs,
    this.purposeOfAcc,
    this.empType,
    this.filedOfEmp,
    this.designationUiValue,
    this.nameOfEmp,
    this.addressOfEmp,
    this.annualIncome,
    this.marketingRefCode,
    this.sourceOfIncome,
    this.expectedTransactionMode,
    this.anticipatedDepositPerMonth,
    this.isPoliticallyExposed,
    this.isInvolvedInPolitics,
    this.isPositionInParty,
    this.isMemberOfInst,
    this.designation,
  });

  String? messageType;
  String? isTaxPayerUs;
  String? purposeOfAcc;
  String? empType;
  String? filedOfEmp;
  String? designationUiValue;
  int? designation;
  String? nameOfEmp;
  AddressOfEmp? addressOfEmp;
  String? annualIncome;
  String? marketingRefCode;
  String? sourceOfIncome;
  String? expectedTransactionMode;
  String? anticipatedDepositPerMonth;
  String? isPoliticallyExposed;
  String? isInvolvedInPolitics;
  String? isPositionInParty;
  String? isMemberOfInst;

  factory EmpDetailRequest.fromJson(Map<String, dynamic> json) => EmpDetailRequest(
    messageType: json["messageType"],
    isTaxPayerUs: json["isTaxPayerUS"],
    purposeOfAcc: json["purposeOfAcc"],
    empType: json["empType"],
    filedOfEmp: json["filedOfEmp"],
    designationUiValue: json["designationUiValue"],
    designation: json["designation"],
    nameOfEmp: json["nameOfEmp"],
    addressOfEmp: AddressOfEmp.fromJson(json["addressOfEmp"]),
    annualIncome: json["annualIncome"],
    marketingRefCode: json["marketingRefCode"],
    sourceOfIncome: json["sourceOfIncome"],
    expectedTransactionMode: json["expectedTransactionMode"],
    anticipatedDepositPerMonth: json["anticipatedDepositPerMonth"],
    isPoliticallyExposed: json["isPoliticallyExposed"],
    isInvolvedInPolitics: json["isInvolvedInPolitics"],
    isPositionInParty: json["isPositionInParty"],
    isMemberOfInst: json["isMemberOfInst"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "isTaxPayerUS": isTaxPayerUs,
    "purposeOfAcc": purposeOfAcc,
    "empType": empType,
    "filedOfEmp": filedOfEmp,
    "designationUiValue": designationUiValue,
    "designation":designation,
    "nameOfEmp": nameOfEmp,
    "addressOfEmp": addressOfEmp!.toJson(),
    "annualIncome": annualIncome,
    "marketingRefCode": marketingRefCode,
    "sourceOfIncome": sourceOfIncome,
    "expectedTransactionMode": expectedTransactionMode,
    "anticipatedDepositPerMonth": anticipatedDepositPerMonth,
    "isPoliticallyExposed": isPoliticallyExposed,
    "isInvolvedInPolitics": isInvolvedInPolitics,
    "isPositionInParty": isPositionInParty,
    "isMemberOfInst": isMemberOfInst,
  };
}

class AddressOfEmp {
  AddressOfEmp({
    this.addressLine1,
    this.addressLine2,
    this.addressLine3,
  });

  String? addressLine1;
  String? addressLine2;
  String? addressLine3;

  factory AddressOfEmp.fromJson(Map<String, dynamic> json) => AddressOfEmp(
    addressLine1: json["addressLine1"],
    addressLine2: json["addressLine2"],
    addressLine3: json["addressLine3"],
  );

  Map<String, dynamic> toJson() => {
    "addressLine1": addressLine1,
    "addressLine2": addressLine2,
    "addressLine3": addressLine3,
  };
}
