// To parse this JSON data, do
//
//     final getHomeDetailsRequest = getHomeDetailsRequestFromJson(jsonString);

import 'dart:convert';

GetHomeDetailsRequest getHomeDetailsRequestFromJson(String str) => GetHomeDetailsRequest.fromJson(json.decode(str));

String getHomeDetailsRequestToJson(GetHomeDetailsRequest data) => json.encode(data.toJson());

class GetHomeDetailsRequest {
  String messageType;
  int timeStamp;

  GetHomeDetailsRequest({
    required this.messageType,
    required this.timeStamp,
  });

  factory GetHomeDetailsRequest.fromJson(Map<String, dynamic> json) => GetHomeDetailsRequest(
    messageType: json["messageType"],
    timeStamp: json["timeStamp"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "timeStamp": timeStamp,
  };
}
