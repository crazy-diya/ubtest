// To parse this JSON data, do
//
//     final getAllScheduleFtRequest = getAllScheduleFtRequestFromJson(jsonString);

import 'dart:convert';

GetAllScheduleFtRequest getAllScheduleFtRequestFromJson(String str) => GetAllScheduleFtRequest.fromJson(json.decode(str));

String getAllScheduleFtRequestToJson(GetAllScheduleFtRequest data) => json.encode(data.toJson());

class GetAllScheduleFtRequest {
  String? messageType;

  GetAllScheduleFtRequest({
    this.messageType,
  });

  factory GetAllScheduleFtRequest.fromJson(Map<String, dynamic> json) => GetAllScheduleFtRequest(
    messageType: json["messageType"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
  };
}
