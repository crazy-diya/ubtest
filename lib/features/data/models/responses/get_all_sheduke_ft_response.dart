// To parse this JSON data, do
//
//     final getAllScheduleFtResponse = getAllScheduleFtResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

GetAllScheduleFtResponse getAllScheduleFtResponseFromJson(String str) => GetAllScheduleFtResponse.fromJson(json.decode(str));

String getAllScheduleFtResponseToJson(GetAllScheduleFtResponse data) => json.encode(data.toJson());

class GetAllScheduleFtResponse extends Serializable{
  List<ScheduleFtList>? scheduleFtList;

  GetAllScheduleFtResponse({
    this.scheduleFtList,
  });

  factory GetAllScheduleFtResponse.fromJson(Map<String, dynamic> json) => GetAllScheduleFtResponse(
    scheduleFtList: List<ScheduleFtList>.from(json["scheduleFTList"].map((x) => ScheduleFtList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "scheduleFTList": List<dynamic>.from(scheduleFtList!.map((x) => x.toJson())),
  };
}

class ScheduleFtList {
  int? scheduleId;
  String? epicUserId;
  int? paymentInstrumentId;
  int? startDay;
  String? toAccountNo;
  String? toBankCode;
  String? toAccountName;
  String? scheduleSource;
  String? scheduleType;
  String? scheduleTitle;
  String? startDate;
  String? endDate;
  String? frequency;
  String? transCategory;
  String? reference;
  int? amount;
  String? remarks;
  String? beneficiaryEmail;
  String? beneficiaryMobile;
  int? failCount;
  String? status;
  String? createdUser;
  String? modifiedUser;
  DateTime? createdDate;
  DateTime? modifiedDate;

  ScheduleFtList({
    this.scheduleId,
    this.epicUserId,
    this.paymentInstrumentId,
    this.startDay,
    this.toAccountNo,
    this.toBankCode,
    this.toAccountName,
    this.scheduleSource,
    this.scheduleType,
    this.scheduleTitle,
    this.startDate,
    this.endDate,
    this.frequency,
    this.transCategory,
    this.reference,
    this.amount,
    this.remarks,
    this.beneficiaryEmail,
    this.beneficiaryMobile,
    this.failCount,
    this.status,
    this.createdUser,
    this.modifiedUser,
    this.createdDate,
    this.modifiedDate,
  });

  factory ScheduleFtList.fromJson(Map<String, dynamic> json) => ScheduleFtList(
    scheduleId: json["scheduleID"],
    epicUserId: json["epicUserId"],
    paymentInstrumentId: json["paymentInstrumentId"],
    startDay: json["startDay"],
    toAccountNo: json["toAccountNo"],
    toBankCode: json["toBankCode"],
    toAccountName: json["toAccountName"],
    scheduleSource: json["scheduleSource"],
    scheduleType: json["scheduleType"],
    scheduleTitle: json["scheduleTitle"],
    startDate: json["startDate"],
    endDate: json["endDate"],
    frequency: json["frequency"],
    transCategory: json["transCategory"],
    reference: json["reference"],
    amount: json["amount"],
    remarks: json["remarks"],
    beneficiaryEmail: json["beneficiaryEmail"],
    beneficiaryMobile: json["beneficiaryMobile"],
    failCount: json["failCount"],
    status: json["status"],
    createdUser: json["createdUser"],
    modifiedUser: json["modifiedUser"],
    createdDate: DateTime.parse(json["createdDate"]),
    modifiedDate: DateTime.parse(json["modifiedDate"]),
  );

  Map<String, dynamic> toJson() => {
    "scheduleID": scheduleId,
    "epicUserId": epicUserId,
    "paymentInstrumentId": paymentInstrumentId,
    "startDay": startDay,
    "toAccountNo": toAccountNo,
    "toBankCode": toBankCode,
    "toAccountName": toAccountName,
    "scheduleSource": scheduleSource,
    "scheduleType": scheduleType,
    "scheduleTitle": scheduleTitle,
    "startDate": startDate,
    "endDate": endDate,
    "frequency": frequency,
    "transCategory": transCategory,
    "reference": reference,
    "amount": amount,
    "remarks": remarks,
    "beneficiaryEmail": beneficiaryEmail,
    "beneficiaryMobile": beneficiaryMobile,
    "failCount": failCount,
    "status": status,
    "createdUser": createdUser,
    "modifiedUser": modifiedUser,
    "createdDate": createdDate!.toIso8601String(),
    "modifiedDate": modifiedDate!.toIso8601String(),
  };
}
