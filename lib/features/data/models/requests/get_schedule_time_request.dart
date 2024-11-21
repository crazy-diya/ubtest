// To parse this JSON data, do
//
//     final getScheduleTimeRequest = getScheduleTimeRequestFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class GetScheduleTimeRequest extends Equatable{
  GetScheduleTimeRequest({
    this.date,
    this.messageType,
  });

  String? date;
  String? messageType;

  factory GetScheduleTimeRequest.fromRawJson(String str) => GetScheduleTimeRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetScheduleTimeRequest.fromJson(Map<String, dynamic> json) => GetScheduleTimeRequest(
    date:json["date"],
    messageType: json["messageType"],
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "messageType": messageType,
  };

  @override
  List<Object?> get props => [date, messageType];
}
