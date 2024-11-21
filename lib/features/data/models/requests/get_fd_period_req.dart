// To parse this JSON data, do
//
//     final getFdPeriodRequest = getFdPeriodRequestFromJson(jsonString);

import 'dart:convert';

GetFdPeriodRequest getFdPeriodRequestFromJson(String str) => GetFdPeriodRequest.fromJson(json.decode(str));

String getFdPeriodRequestToJson(GetFdPeriodRequest data) => json.encode(data.toJson());

class GetFdPeriodRequest {
  String? messageType;

  GetFdPeriodRequest({
    this.messageType,
  });

  factory GetFdPeriodRequest.fromJson(Map<String, dynamic> json) => GetFdPeriodRequest(
    messageType: json["messageType"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
  };
}
