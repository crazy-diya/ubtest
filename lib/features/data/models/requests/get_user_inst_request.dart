// To parse this JSON data, do
//
//     final getUserInstRequest = getUserInstRequestFromJson(jsonString);

import 'dart:convert';

GetUserInstRequest getUserInstRequestFromJson(String str) =>
    GetUserInstRequest.fromJson(json.decode(str));

String getUserInstRequestToJson(GetUserInstRequest data) =>
    json.encode(data.toJson());

class GetUserInstRequest {
  GetUserInstRequest({
    this.messageType,
    this.requestType,
  });

  String? messageType;
  String? requestType;

  factory GetUserInstRequest.fromJson(Map<String, dynamic> json) =>
      GetUserInstRequest(
        messageType: json["messageType"],
        requestType: json["requestType"],
      );

  Map<String, dynamic> toJson() => {
        "messageType": messageType,
        "requestType": requestType,
      };
}
