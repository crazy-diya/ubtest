// To parse this JSON data, do
//
//     final getNotificationSettingsRequest = getNotificationSettingsRequestFromJson(jsonString);

import 'dart:convert';

GetNotificationSettingsRequest getNotificationSettingsRequestFromJson(
        String str) =>
    GetNotificationSettingsRequest.fromJson(json.decode(str));

String getNotificationSettingsRequestToJson(
        GetNotificationSettingsRequest data) =>
    json.encode(data.toJson());

class GetNotificationSettingsRequest {
  final String? messageType;

  GetNotificationSettingsRequest({
    this.messageType,
  });

  factory GetNotificationSettingsRequest.fromJson(Map<String, dynamic> json) =>
      GetNotificationSettingsRequest(
        messageType: json["messageType"],
      );

  Map<String, dynamic> toJson() => {
        "messageType": messageType,
      };
}
