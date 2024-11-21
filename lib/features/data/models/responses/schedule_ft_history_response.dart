// To parse this JSON data, do
//
//     final scheduleFtHistoryResponse = scheduleFtHistoryResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

ScheduleFtHistoryResponse scheduleFtHistoryResponseFromJson(String str) => ScheduleFtHistoryResponse.fromJson(json.decode(str));

String scheduleFtHistoryResponseToJson(ScheduleFtHistoryResponse data) => json.encode(data.toJson());

class ScheduleFtHistoryResponse extends Serializable{
  String? paidFrom;
  String? paidFromName;
  String? paidTo;
  String? paidToName;
  String? scheduleTitle;
  String? fromBankCode;
  String? toBankCode;
  double? amount;
  int? count;
  List<SchFundTransferHistoryResponseTempDtoList>? schFundTransferHistoryResponseTempDtoList;

  ScheduleFtHistoryResponse({
     this.paidFrom,
     this.paidFromName,
     this.paidTo,
     this.paidToName,
     this.scheduleTitle,
     this.fromBankCode,
     this.toBankCode,
     this.amount,
     this.count,
     this.schFundTransferHistoryResponseTempDtoList,
  });

  factory ScheduleFtHistoryResponse.fromJson(Map<String, dynamic> json) => ScheduleFtHistoryResponse(
    paidFrom: json["paidFrom"],
    paidFromName: json["paidFromName"],
    paidTo: json["paidTo"],
    paidToName: json["paidToName"],
    scheduleTitle: json["scheduleTitle"],
    fromBankCode: json["fromBankCode"],
    toBankCode: json["toBankCode"],
    amount: json["amount"],
    count: json["count"],
    schFundTransferHistoryResponseTempDtoList: List<SchFundTransferHistoryResponseTempDtoList>.from(json["schFundTransferHistoryResponseTempDTOList"].map((x) => SchFundTransferHistoryResponseTempDtoList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "paidFrom": paidFrom,
    "paidFromName": paidFromName,
    "paidTo": paidTo,
    "paidToName": paidToName,
    "scheduleTitle": scheduleTitle,
    "fromBankCode": fromBankCode,
    "toBankCode": toBankCode,
    "amount": amount,
    "count": count,
    "schFundTransferHistoryResponseTempDTOList": List<dynamic>.from(schFundTransferHistoryResponseTempDtoList!.map((x) => x.toJson())),
  };
}

class SchFundTransferHistoryResponseTempDtoList {
  DateTime? date;
  String? status;
  num? scheduleAmount;

  SchFundTransferHistoryResponseTempDtoList({
     this.date,
     this.status,
     this.scheduleAmount,
  });

  factory SchFundTransferHistoryResponseTempDtoList.fromJson(Map<String, dynamic> json) => SchFundTransferHistoryResponseTempDtoList(
    date: DateTime.parse(json["date"]),
    status: json["status"],
    scheduleAmount: json["scheduleAmount"],
  );

  Map<String, dynamic> toJson() => {
    "date": date!.toIso8601String(),
    "status": status,
    "scheduleAmount": scheduleAmount,
  };
}
