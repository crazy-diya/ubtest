import 'dart:convert';

class ScheduleVerificationRequest {
  ScheduleVerificationRequest({
    this.date,
    this.timeSlot,
    this.language,
  });

  String? date;
  String? timeSlot;
  String? language;

  factory ScheduleVerificationRequest.fromRawJson(String str) =>
      ScheduleVerificationRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ScheduleVerificationRequest.fromJson(Map<String, dynamic> json) =>
      ScheduleVerificationRequest(
        date: json["date"],
        timeSlot: json["timeSlot"],
        language: json["language"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "timeSlot": timeSlot,
        "language": language,
      };
}
