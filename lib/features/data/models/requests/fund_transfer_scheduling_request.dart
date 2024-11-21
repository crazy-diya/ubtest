// To parse this JSON data, do
//
//     final schedulingFundTransferRequest = schedulingFundTransferRequestFromJson(jsonString);

import 'dart:convert';

SchedulingFundTransferRequest schedulingFundTransferRequestFromJson(String str) => SchedulingFundTransferRequest.fromJson(json.decode(str));

String schedulingFundTransferRequestToJson(SchedulingFundTransferRequest data) => json.encode(data.toJson());

class SchedulingFundTransferRequest {
    String? messageType;
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
    DateTime? startDate;
    DateTime? endDate;
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
    DateTime? createdDate;
    DateTime? modifiedDate;
    String? fromAccountNo;
    String? fromBankCode;
    String? fromAccountName;
    double? serviceCharge;
    int? noOfTransfers;
    int? oneTime;
    String? deviceChannel;
    String? billerId;

    SchedulingFundTransferRequest({
        this.messageType,
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
        this.fromAccountNo,
        this.fromBankCode,
        this.fromAccountName,
        this.serviceCharge,
        this.noOfTransfers,
        this.oneTime,
        this.deviceChannel,
        this.billerId,
    });

    factory SchedulingFundTransferRequest.fromJson(Map<String, dynamic> json) => SchedulingFundTransferRequest(
        messageType: json["messageType"],
        tranType: json["tranType"],
        scheduleId: json["scheduleID"],
        paymentInstrumentId: json["paymentInstrumentId"],
        startDay: json["startDay"],
        toAccountNo: json["toAccountNo"],
        toBankCode: json["toBankCode"],
        toAccountName: json["toAccountName"],
        scheduleSource: json["scheduleSource"],
        scheduleType: json["scheduleType"],
        scheduleTitle: json["scheduleTitle"],
        startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
        endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
        frequency: json["frequency"],
        transCategory: json["transCategory"],
        reference: json["reference"],
        amount: json["amount"]?.toDouble(),
        remarks: json["remarks"],
        beneficiaryEmail: json["beneficiaryEmail"],
        beneficiaryMobile: json["beneficiaryMobile"],
        failCount: json["failCount"],
        status: json["status"],
        createdUser: json["createdUser"],
        modifiedUser: json["modifiedUser"],
        createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
        modifiedDate: json["modifiedDate"] == null ? null : DateTime.parse(json["modifiedDate"]),
        fromAccountNo: json["fromAccountNo"],
        fromBankCode: json["fromBankCode"],
        fromAccountName: json["fromAccountName"],
        serviceCharge: json["serviceCharge"]?.toDouble(),
        noOfTransfers: json["noOfTransfers"],
        oneTime: json["oneTime"],
        deviceChannel: json["deviceChannel"],
        billerId: json["billerId"],
    );

    Map<String, dynamic> toJson() => {
        "messageType": messageType,
        "tranType": tranType,
        "scheduleID": scheduleId,
        "paymentInstrumentId": paymentInstrumentId,
        "startDay": startDay,
        "toAccountNo": toAccountNo,
        "toBankCode": toBankCode,
        "toAccountName": toAccountName,
        "scheduleSource": scheduleSource,
        "scheduleType": scheduleType,
        "scheduleTitle": scheduleTitle,
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
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
        "createdDate": createdDate?.toIso8601String(),
        "modifiedDate":modifiedDate?.toIso8601String(),
        "fromAccountNo": fromAccountNo,
        "fromBankCode": fromBankCode,
        "fromAccountName": fromAccountName,
        "serviceCharge": serviceCharge,
        "noOfTransfers": noOfTransfers,
        "oneTime": oneTime,
        "deviceChannel": deviceChannel,
        "billerId": billerId,
    };
}
