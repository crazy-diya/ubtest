// To parse this JSON data, do
//
//     final deleteFtScheduleRequest = deleteFtScheduleRequestFromJson(jsonString);

import 'dart:convert';

DeleteFtScheduleRequest deleteFtScheduleRequestFromJson(String str) => DeleteFtScheduleRequest.fromJson(json.decode(str));

String deleteFtScheduleRequestToJson(DeleteFtScheduleRequest data) => json.encode(data.toJson());

class DeleteFtScheduleRequest {
  String? messageType;
  int? scheduleId;
  String? remarks;

  DeleteFtScheduleRequest({
    required this.messageType,
    required this.scheduleId,
    this.remarks,
  });

  factory DeleteFtScheduleRequest.fromJson(Map<String, dynamic> json) => DeleteFtScheduleRequest(
    messageType: json["messageType"],
    scheduleId: json["scheduleID"],
    remarks: json["remarks"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "scheduleID": scheduleId,
    "remarks": remarks,
  };
}
