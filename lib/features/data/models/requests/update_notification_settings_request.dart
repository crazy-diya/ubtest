// To parse this JSON data, do
//
//     final updateNotificationSettingsRequest = updateNotificationSettingsRequestFromJson(jsonString);

import 'dart:convert';

UpdateNotificationSettingsRequest updateNotificationSettingsRequestFromJson(
        String str) =>
    UpdateNotificationSettingsRequest.fromJson(json.decode(str));

String updateNotificationSettingsRequestToJson(
        UpdateNotificationSettingsRequest data) =>
    json.encode(data.toJson());

class UpdateNotificationSettingsRequest {
  final String? messageType;
  final bool? notificationModeSms;
  final bool? notificationModeEmail;

  UpdateNotificationSettingsRequest({
    this.messageType,
    this.notificationModeSms,
    this.notificationModeEmail,
  });

  factory UpdateNotificationSettingsRequest.fromJson(
          Map<String, dynamic> json) =>
      UpdateNotificationSettingsRequest(
        messageType: json["messageType"],
        notificationModeSms: json["notificationModeSms"],
        notificationModeEmail: json["notificationModeEmail"],
      );

  Map<String, dynamic> toJson() => {
        "messageType": messageType,
        "notificationModeSms": notificationModeSms,
        "notificationModeEmail": notificationModeEmail,
      };
}
