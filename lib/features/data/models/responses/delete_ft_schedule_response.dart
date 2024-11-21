// To parse this JSON data, do
//
//     final deleteFtScheduleResponse = deleteFtScheduleResponseFromJson(jsonString);

// To parse this JSON data, do
//
//     final deleteFtScheduleResponse = deleteFtScheduleResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

DeleteFtScheduleResponse deleteFtScheduleResponseFromJson(String str) => DeleteFtScheduleResponse.fromJson(json.decode(str));

String deleteFtScheduleResponseToJson(DeleteFtScheduleResponse data) => json.encode(data.toJson());

class DeleteFtScheduleResponse extends Serializable{
  bool? scheduleCanceled;

  DeleteFtScheduleResponse({
    required this.scheduleCanceled,
  });

  factory DeleteFtScheduleResponse.fromJson(Map<String, dynamic> json) => DeleteFtScheduleResponse(
    scheduleCanceled: json["schedule_canceled"],
  );

  Map<String, dynamic> toJson() => {
    "schedule_canceled": scheduleCanceled,
  };
}
