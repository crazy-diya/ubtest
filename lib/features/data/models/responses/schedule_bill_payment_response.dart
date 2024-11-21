// To parse this JSON data, do
//
//     final scheduleBillPaymentResponse = scheduleBillPaymentResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

ScheduleBillPaymentResponse scheduleBillPaymentResponseFromJson(String str) => ScheduleBillPaymentResponse.fromJson(json.decode(str));

String scheduleBillPaymentResponseToJson(ScheduleBillPaymentResponse data) => json.encode(data.toJson());

class ScheduleBillPaymentResponse extends Serializable {
  String? tranType;
  int? scheduleId;
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
  double? amount;
  String? remarks;
  String? beneficiaryEmail;
  String? beneficiaryMobile;
  int? failCount;
  String? status;
  String? createdUser;
  String? modifiedUser;
  String? createdDate;
  String? modifiedDate;
  String? billerId;
  String? fromAccountNo;
  String? fromAccountName;
  int? noOfTransfers;
  double? serviceCharge;

  ScheduleBillPaymentResponse({
    this.tranType,
    this.scheduleId,
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
    this.billerId,
    this.fromAccountNo,
    this.fromAccountName,
    this.noOfTransfers,
    this.serviceCharge,
  });

  factory ScheduleBillPaymentResponse.fromJson(Map<String, dynamic> json) => ScheduleBillPaymentResponse(
    scheduleId: json["scheduleID"],
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
    createdDate: json["createdDate"],
    modifiedDate: json["modifiedDate"],
    billerId: json["billerId"],
    fromAccountNo: json["fromAccountNo"],
    fromAccountName: json["fromAccountName"],
    noOfTransfers: json["noOfTransfers"],
    serviceCharge: json["serviceCharge"],
  );

  Map<String, dynamic> toJson() => {
    "scheduleID": scheduleId,
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
    "createdDate": createdDate,
    "modifiedDate": modifiedDate,
    "billerId": billerId,
    "fromAccountNo": fromAccountNo,
    "fromAccountName": fromAccountName,
    "noOfTransfers": noOfTransfers,
    "serviceCharge": serviceCharge,
  };
}
