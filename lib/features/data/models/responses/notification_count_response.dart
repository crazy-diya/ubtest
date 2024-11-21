// To parse this JSON data, do
//
//     final notificationCountResponse = notificationCountResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

NotificationCountResponse notificationCountResponseFromJson(String str) => NotificationCountResponse.fromJson(json.decode(str));

String notificationCountResponseToJson(NotificationCountResponse data) => json.encode(data.toJson());

class NotificationCountResponse extends Serializable{
  int? allNotificationCount;
  int? promoNotificationCount;
  int? tranNotificationCount;
  int? noticesNotificationCount;

  NotificationCountResponse({
    this.allNotificationCount,
    this.promoNotificationCount,
    this.tranNotificationCount,
    this.noticesNotificationCount,
  });

  factory NotificationCountResponse.fromJson(Map<String, dynamic> json) => NotificationCountResponse(
    allNotificationCount: json["allNotificationCount"],
    promoNotificationCount: json["promoNotificationCount"],
    tranNotificationCount: json["tranNotificationCount"],
    noticesNotificationCount: json["noticesNotificationCount"],
  );

  Map<String, dynamic> toJson() => {
    "allNotificationCount": allNotificationCount,
    "promoNotificationCount": promoNotificationCount,
    "tranNotificationCount": tranNotificationCount,
    "noticesNotificationCount": noticesNotificationCount,
  };
}
