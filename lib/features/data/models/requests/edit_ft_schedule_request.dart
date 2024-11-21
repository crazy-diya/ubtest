// To parse this JSON data, do
//
//     final editFtScheduleRequest = editFtScheduleRequestFromJson(jsonString);

import 'dart:convert';

EditFtScheduleRequest editFtScheduleRequestFromJson(String str) => EditFtScheduleRequest.fromJson(json.decode(str));

String editFtScheduleRequestToJson(EditFtScheduleRequest data) => json.encode(data.toJson());

class EditFtScheduleRequest {
  String? messageType;
  int? scheduleId;
  String? startDate;
  String? endDate;
  String? beneficiaryEmail;
  String? beneficiaryMobile;
  int? amount;

  EditFtScheduleRequest({
    required this.messageType,
    required this.scheduleId,
    required this.startDate,
    required this.endDate,
    required this.beneficiaryEmail,
    required this.beneficiaryMobile,
    required this.amount,
  });

  factory EditFtScheduleRequest.fromJson(Map<String, dynamic> json) => EditFtScheduleRequest(
    messageType: json["messageType"],
    scheduleId: json["scheduleID"],
    startDate: json["startDate"],
    endDate: json["endDate"],
    beneficiaryEmail: json["beneficiaryEmail"],
    beneficiaryMobile: json["beneficiaryMobile"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "scheduleID": scheduleId,
    "startDate": startDate,
    "endDate": endDate,
    "beneficiaryEmail": beneficiaryEmail,
    "beneficiaryMobile": beneficiaryMobile,
    "amount": amount,
  };
}
