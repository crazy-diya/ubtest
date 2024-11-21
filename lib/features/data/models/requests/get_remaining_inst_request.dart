// To parse this JSON data, do
//
//     final getRemainingInstRequest = getRemainingInstRequestFromJson(jsonString);

import 'dart:convert';

GetRemainingInstRequest getRemainingInstRequestFromJson(String str) =>
    GetRemainingInstRequest.fromJson(json.decode(str));

String getRemainingInstRequestToJson(GetRemainingInstRequest data) =>
    json.encode(data.toJson());

class GetRemainingInstRequest {
  GetRemainingInstRequest({
    this.messageType,
    this.requestType,
  });

  String? messageType;
  String? requestType;

  factory GetRemainingInstRequest.fromJson(Map<String, dynamic> json) =>
      GetRemainingInstRequest(
        messageType: json["messageType"],
        requestType: json["requestType"],
      );

  Map<String, dynamic> toJson() => {
        "messageType": messageType,
        "requestType": requestType,
      };
}
