// To parse this JSON data, do
//
//     final deleteNotificationRequest = deleteNotificationRequestFromJson(jsonString);

import 'dart:convert';

DeleteNotificationRequest deleteNotificationRequestFromJson(String str) => DeleteNotificationRequest.fromJson(json.decode(str));

String deleteNotificationRequestToJson(DeleteNotificationRequest data) => json.encode(data.toJson());

class DeleteNotificationRequest {
  String? epicUserId;
  int? page;
  int? size;
  List<int>? notificationIds;

  DeleteNotificationRequest({
    this.epicUserId,
    this.page,
    this.size,
    this.notificationIds,
  });

  factory DeleteNotificationRequest.fromJson(Map<String, dynamic> json) => DeleteNotificationRequest(
    epicUserId: json["epicUserId"],
    page: json["page"],
    size: json["size"],
    notificationIds: List<int>.from(json["notificationIds"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "epicUserId": epicUserId,
    "page": page,
    "size": size,
    "notificationIds": List<dynamic>.from(notificationIds!.map((x) => x)),
  };
}
