// To parse this JSON data, do
//
//     final getScheduleTimeResponse = getScheduleTimeResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

class GetScheduleTimeResponse extends Serializable{
  GetScheduleTimeResponse({
    this.timeSlots,
  });

  List<String>? timeSlots;

  factory GetScheduleTimeResponse.fromRawJson(String str) => GetScheduleTimeResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetScheduleTimeResponse.fromJson(Map<String, dynamic> json) => GetScheduleTimeResponse(
    timeSlots: List<String>.from(json["timeSlots"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "timeSlots": List<dynamic>.from(timeSlots!.map((x) => x)),
  };
}
