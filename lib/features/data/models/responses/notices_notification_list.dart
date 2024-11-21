// // To parse this JSON data, do
// //
// //     final noticesNotificationResponse = noticesNotificationResponseFromJson(jsonString);
//
// import 'dart:convert';
//
// import 'package:union_bank_mobile/features/data/models/common/base_response.dart';
//
// NoticesNotificationResponse noticesNotificationResponseFromJson(String str) => NoticesNotificationResponse.fromJson(json.decode(str));
//
// String noticesNotificationResponseToJson(NoticesNotificationResponse data) => json.encode(data.toJson());
//
// class NoticesNotificationResponse extends Serializable{
//   int count;
//   int totalUnread;
//   List<NoticesNotificationResponseDtoList> userNotificationResponseDtoList;
//
//   NoticesNotificationResponse({
//     required this.count,
//     required this.totalUnread,
//     required this.userNotificationResponseDtoList,
//   });
//
//   factory NoticesNotificationResponse.fromJson(Map<String, dynamic> json) => NoticesNotificationResponse(
//     count: json["count"],
//     totalUnread: json["totalUnread"],
//     userNotificationResponseDtoList: List<NoticesNotificationResponseDtoList>.from(json["userNotificationResponseDTOList"].map((x) => NoticesNotificationResponseDtoList.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "count": count,
//     "totalUnread": totalUnread,
//     "userNotificationResponseDTOList": List<dynamic>.from(userNotificationResponseDtoList.map((x) => x.toJson())),
//   };
// }
//
// class NoticesNotificationResponseDtoList {
//   String title;
//   int notificationId;
//   String code;
//   String description;
//   String status;
//   DateTime createdDate;
//   DateTime modifiedDate;
//
//   NoticesNotificationResponseDtoList({
//     required this.title,
//     required this.notificationId,
//     required this.code,
//     required this.description,
//     required this.status,
//     required this.createdDate,
//     required this.modifiedDate,
//   });
//
//   factory NoticesNotificationResponseDtoList.fromJson(Map<String, dynamic> json) => NoticesNotificationResponseDtoList(
//     title: json["title"],
//     notificationId: json["notificationId"],
//     code: json["code"],
//     description: json["description"],
//     status: json["status"],
//     createdDate: DateTime.parse(json["createdDate"]),
//     modifiedDate: DateTime.parse(json["modifiedDate"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "title": title,
//     "notificationId": notificationId,
//     "code": code,
//     "description": description,
//     "status": status,
//     "createdDate": createdDate.toIso8601String(),
//     "modifiedDate": modifiedDate.toIso8601String(),
//   };
// }
// To parse this JSON data, do
//
//     final noticesNotificationResponse = noticesNotificationResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

NoticesNotificationResponse noticesNotificationResponseFromJson(String str) => NoticesNotificationResponse.fromJson(json.decode(str));

String noticesNotificationResponseToJson(NoticesNotificationResponse data) => json.encode(data.toJson());

class NoticesNotificationResponse extends Serializable{
  final int? count;
  final int? totalUnread;
  final List<NoticesNotificationResponseDtoList>? userNotificationResponseDtoList;

  NoticesNotificationResponse({
    this.count,
    this.totalUnread,
    this.userNotificationResponseDtoList,
  });

  factory NoticesNotificationResponse.fromJson(Map<String, dynamic> json) => NoticesNotificationResponse(
    count: json["count"],
    totalUnread: json["totalUnread"],
    userNotificationResponseDtoList: json["userNotificationResponseDTOList"] == null ? [] : List<NoticesNotificationResponseDtoList>.from(json["userNotificationResponseDTOList"]!.map((x) => NoticesNotificationResponseDtoList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "totalUnread": totalUnread,
    "userNotificationResponseDTOList": userNotificationResponseDtoList == null ? [] : List<dynamic>.from(userNotificationResponseDtoList!.map((x) => x.toJson())),
  };
}

class NoticesNotificationResponseDtoList {
  final String title;
  final int notificationId;
  final String code;
  final String description;
  final String? status;
  final DateTime createdDate;
  final DateTime modifiedDate;
  final int? readStatus;

  NoticesNotificationResponseDtoList({
    this.readStatus,
    required this.title,
    required this.notificationId,
    required this.code,
    required this.description,
    this.status,
    required this.createdDate,
    required this.modifiedDate,
  });

  factory NoticesNotificationResponseDtoList.fromJson(Map<String, dynamic> json) => NoticesNotificationResponseDtoList(
    title: json["title"],
    notificationId: json["notificationId"],
    code: json["code"],
    description: json["description"],
    status: json["status"],
    createdDate: DateTime.parse(json["createdDate"]),
    modifiedDate: DateTime.parse(json["modifiedDate"]),
    readStatus: json["readStatus"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "notificationId": notificationId,
    "code": code,
    "description": description,
    "status": status,
    "createdDate": createdDate.toIso8601String(),
    "modifiedDate": modifiedDate.toIso8601String(),
    "readStatus": readStatus,
  };
}
