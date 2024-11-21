// To parse this JSON data, do
//
//     final editFtScheduleResponse = editFtScheduleResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

EditFtScheduleResponse editFtScheduleResponseFromJson(String str) => EditFtScheduleResponse.fromJson(json.decode(str));

String editFtScheduleResponseToJson(EditFtScheduleResponse data) => json.encode(data.toJson());

class EditFtScheduleResponse extends Serializable{
  String? responseCode;
  String? responseDescription;
  EditScheduleData? data;

  EditFtScheduleResponse({
    required this.responseCode,
    required this.responseDescription,
    required this.data,
  });

  factory EditFtScheduleResponse.fromJson(Map<String, dynamic> json) => EditFtScheduleResponse(
    responseCode: json["responseCode"],
    responseDescription: json["responseDescription"],
    data:json["data"] != null ? EditScheduleData.fromJson(json["data"]): EditScheduleData(),
  );

  Map<String, dynamic> toJson() => {
    "responseCode": responseCode,
    "responseDescription": responseDescription,
    "data": data!.toJson(),
  };
}

class EditScheduleData {
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
  DateTime? startDate;
  DateTime? endDate;
  String? frequency;
  String? transCategory;
  String? tranType;
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

  EditScheduleData({
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
    this.tranType,
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

  factory EditScheduleData.fromJson(Map<String, dynamic> json) => EditScheduleData(
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
    startDate: DateTime.parse(json["startDate"]),
    endDate: DateTime.parse(json["endDate"]),
    frequency: json["frequency"],
    transCategory: json["transCategory"],
    tranType: json["tranType"],
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
    "startDate": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
    "endDate": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
    "frequency": frequency,
    "transCategory": transCategory,
    "tranType": tranType,
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
