// To parse this JSON data, do
//
//     final getFdRateRequest = getFdRateRequestFromJson(jsonString);

import 'dart:convert';

GetFdRateRequest getFdRateRequestFromJson(String str) => GetFdRateRequest.fromJson(json.decode(str));

String getFdRateRequestToJson(GetFdRateRequest data) => json.encode(data.toJson());

class GetFdRateRequest {
  final String? messageType;
  final DateTime? acceptedDate;

  GetFdRateRequest({
    this.messageType,
    this.acceptedDate,
  });

  factory GetFdRateRequest.fromJson(Map<String, dynamic> json) => GetFdRateRequest(
    messageType: json["messageType"],
    acceptedDate: json["acceptedDate"] == null ? null : DateTime.parse(json["acceptedDate"]),
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "acceptedDate": acceptedDate?.toIso8601String(),
  };
}
