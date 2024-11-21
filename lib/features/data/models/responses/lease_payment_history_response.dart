// To parse this JSON data, do
//
//     final leaseHistoryresponse = leaseHistoryresponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

LeaseHistoryresponse leaseHistoryresponseFromJson(String str) => LeaseHistoryresponse.fromJson(json.decode(str));

String leaseHistoryresponseToJson(LeaseHistoryresponse data) => json.encode(data.toJson());

class LeaseHistoryresponse extends Serializable{
  List<LeaseHistoryResponseDto>? leaseHistoryResponseDtos;
  int count;

  LeaseHistoryresponse({
     this.leaseHistoryResponseDtos,
    required this.count,
  });

  factory LeaseHistoryresponse.fromJson(Map<String, dynamic> json) => LeaseHistoryresponse(
    leaseHistoryResponseDtos: List<LeaseHistoryResponseDto>.from(json["leaseHistoryResponseDTOS"].map((x) => LeaseHistoryResponseDto.fromJson(x))),
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "leaseHistoryResponseDTOS": List<dynamic>.from(leaseHistoryResponseDtos!.map((x) => x.toJson())),
    "count": count,
  };
}

class LeaseHistoryResponseDto {
  String fromAccountNo;
  String toAccountNo;
  String transactionAmount;
  String referenceNumber;
  String remarks;
  DateTime transactionDateTime;

  LeaseHistoryResponseDto({
    required this.fromAccountNo,
    required this.toAccountNo,
    required this.transactionAmount,
    required this.referenceNumber,
    required this.remarks,
    required this.transactionDateTime,
  });

  factory LeaseHistoryResponseDto.fromJson(Map<String, dynamic> json) => LeaseHistoryResponseDto(
    fromAccountNo: json["fromAccountNo"],
    toAccountNo: json["toAccountNo"],
    transactionAmount: json["transactionAmount"],
    referenceNumber: json["referenceNumber"],
    remarks: json["remarks"],
    transactionDateTime: DateTime.parse(json["transactionDateTime"]),
  );

  Map<String, dynamic> toJson() => {
    "fromAccountNo": fromAccountNo,
    "toAccountNo": toAccountNo,
    "transactionAmount": transactionAmount,
    "referenceNumber": referenceNumber,
    "remarks": remarks,
    "transactionDateTime": transactionDateTime.toIso8601String(),
  };
}
