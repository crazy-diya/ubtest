// To parse this JSON data, do
//
//     final notificationCountRequest = notificationCountRequestFromJson(jsonString);

import 'dart:convert';

NotificationCountRequest notificationCountRequestFromJson(String str) => NotificationCountRequest.fromJson(json.decode(str));

String notificationCountRequestToJson(NotificationCountRequest data) => json.encode(data.toJson());

class NotificationCountRequest {
  String? readStatus;
  String? notificationType;

  NotificationCountRequest({
    this.readStatus,
    this.notificationType,
  });

  factory NotificationCountRequest.fromJson(Map<String, dynamic> json) => NotificationCountRequest(
    readStatus: json["readStatus"],
    notificationType: json["notificationType"],
  );

  Map<String, dynamic> toJson() => {
    "readStatus": readStatus,
    "notificationType": notificationType,
  };
}
