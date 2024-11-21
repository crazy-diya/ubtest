// To parse this JSON data, do
//
//     final markAsReadNotificationRequest = markAsReadNotificationRequestFromJson(jsonString);

import 'dart:convert';

MarkAsReadNotificationRequest markAsReadNotificationRequestFromJson(String str) => MarkAsReadNotificationRequest.fromJson(json.decode(str));

String markAsReadNotificationRequestToJson(MarkAsReadNotificationRequest data) => json.encode(data.toJson());

class MarkAsReadNotificationRequest {
  String? epicUserId;
  List<int>? notificationIds;

  MarkAsReadNotificationRequest({
    this.epicUserId,
    this.notificationIds,
  });

  factory MarkAsReadNotificationRequest.fromJson(Map<String, dynamic> json) => MarkAsReadNotificationRequest(
    epicUserId: json["epicUserId"],
    notificationIds: List<int>.from(json["notificationIds"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "epicUserId": epicUserId,
    "notificationIds": notificationIds != null ? List<dynamic>.from(notificationIds!.map((x) => x)) : [],
  };

  List<Object?> get props => [epicUserId,notificationIds];
}
