// // To parse this JSON data, do
// //
// //     final noticesNotificationRequest = noticesNotificationRequestFromJson(jsonString);
//
// import 'dart:convert';
//
// NoticesNotificationRequest noticesNotificationRequestFromJson(String str) => NoticesNotificationRequest.fromJson(json.decode(str));
//
// String noticesNotificationRequestToJson(NoticesNotificationRequest data) => json.encode(data.toJson());
//
// class NoticesNotificationRequest {
//   String epicUserId;
//   int page;
//   int size;
//
//   NoticesNotificationRequest({
//     required this.epicUserId,
//     required this.page,
//     required this.size,
//   });
//
//   factory NoticesNotificationRequest.fromJson(Map<String, dynamic> json) => NoticesNotificationRequest(
//     epicUserId: json["epicUserId"],
//     page: json["page"],
//     size: json["size"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "epicUserId": epicUserId,
//     "page": page,
//     "size": size,
//   };
// }

// To parse this JSON data, do
//
//     final noticesNotificationRequest = noticesNotificationRequestFromJson(jsonString);

import 'dart:convert';

NoticesNotificationRequest noticesNotificationRequestFromJson(String str) => NoticesNotificationRequest.fromJson(json.decode(str));

String noticesNotificationRequestToJson(NoticesNotificationRequest data) => json.encode(data.toJson());

class NoticesNotificationRequest {
  String? epicUserId;
  int? page;
  int? size;
  String? readStatus;

  NoticesNotificationRequest({
    this.epicUserId,
    this.page,
    this.size,
    this.readStatus,
  });

  factory NoticesNotificationRequest.fromJson(Map<String, dynamic> json) => NoticesNotificationRequest(
    epicUserId: json["epicUserId"],
    page: json["page"],
    size: json["size"],
    readStatus: json["readStatus"],
  );

  Map<String, dynamic> toJson() => {
    "epicUserId": epicUserId,
    "page": page,
    "size": size,
    "readStatus": readStatus,
  };
}
