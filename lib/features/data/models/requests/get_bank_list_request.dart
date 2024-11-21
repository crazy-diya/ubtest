// To parse this JSON data, do
//
//     final getScheduleTimeRequest = getScheduleTimeRequestFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class GetBankListRequest extends Equatable{
  GetBankListRequest({
    this.messageType,
  });

  String? messageType;

  factory GetBankListRequest.fromRawJson(String str) => GetBankListRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetBankListRequest.fromJson(Map<String, dynamic> json) => GetBankListRequest(
    messageType: json["messageType"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
  };

  @override
  List<Object?> get props => [messageType];
}
