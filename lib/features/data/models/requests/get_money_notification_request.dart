// To parse this JSON data, do
//
//     final getMoneyNotificationRequest = getMoneyNotificationRequestFromJson(jsonString);

import 'dart:convert';

GetMoneyNotificationRequest getMoneyNotificationRequestFromJson(String str) => GetMoneyNotificationRequest.fromJson(json.decode(str));

String getMoneyNotificationRequestToJson(GetMoneyNotificationRequest data) => json.encode(data.toJson());

class GetMoneyNotificationRequest {
  final String? messageType;
  final String? requestMoneyId;

  GetMoneyNotificationRequest({
    this.messageType,
    this.requestMoneyId,
  });

  factory GetMoneyNotificationRequest.fromJson(Map<String, dynamic> json) => GetMoneyNotificationRequest(
    messageType: json["messageType"],
    requestMoneyId: json["requestMoneyId"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "requestMoneyId": requestMoneyId,
  };
}
