// To parse this JSON data, do
//
//     final scheduleBillPaymentRequest = scheduleBillPaymentRequestFromJson(jsonString);

import 'dart:convert';

ScheduleBillPaymentRequest scheduleBillPaymentRequestFromJson(String str) => ScheduleBillPaymentRequest.fromJson(json.decode(str));

String scheduleBillPaymentRequestToJson(ScheduleBillPaymentRequest data) => json.encode(data.toJson());

class ScheduleBillPaymentRequest {
  String? messageType;
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
  String? amount;
  String? remarks;
  String? beneficiaryEmail;
  String? beneficiaryMobile;
  int? failCount;
  String? status;
  String? createdUser;
  String? modifiedUser;
  String? createdDate;
  String? modifiedDate;
  String? tranType;
  String? billerId;

  ScheduleBillPaymentRequest({
    this.messageType,
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
    this.tranType,
    this.billerId,
  });

  factory ScheduleBillPaymentRequest.fromJson(Map<String, dynamic> json) => ScheduleBillPaymentRequest(
    messageType: json["messageType"],
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
    tranType: json["tranType"],
    billerId: json["billerId"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
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
    "tranType": tranType,
    "billerId": billerId,
  };
}
