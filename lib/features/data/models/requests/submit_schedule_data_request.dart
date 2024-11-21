// To parse this JSON data, do
//
//     final submitScheduleDataRequest = submitScheduleDataRequestFromJson(jsonString);

import 'dart:convert';

class SubmitScheduleDataRequest {
  SubmitScheduleDataRequest({
    this.messageType,
    this.language,
    this.date,
    this.timeSlot,
  });

  String? messageType;
  String? language;
  String? date;
  String? timeSlot;

  factory SubmitScheduleDataRequest.fromRawJson(String str) => SubmitScheduleDataRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SubmitScheduleDataRequest.fromJson(Map<String, dynamic> json) => SubmitScheduleDataRequest(
    messageType: json["messageType"],
    language: json["language"],
    date: json["date"],
    timeSlot: json["timeSlot"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "language": language,
    "date": date,
    "timeSlot": timeSlot,
  };
}
