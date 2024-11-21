// To parse this JSON data, do
//
//     final getScheduleTimeRequest = getScheduleTimeRequestFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class GetBranchListRequest extends Equatable{
  GetBranchListRequest({
    this.messageType,
    this.branchCode
  });

  String? messageType;
  String? branchCode;

  factory GetBranchListRequest.fromRawJson(String str) => GetBranchListRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetBranchListRequest.fromJson(Map<String, dynamic> json) => GetBranchListRequest(
    messageType: json["messageType"],
    branchCode: json["bankCode"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "bankCode": branchCode,
  };

  @override
  List<Object?> get props => [messageType];
}
