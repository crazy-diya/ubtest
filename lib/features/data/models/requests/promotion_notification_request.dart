// // To parse this JSON data, do
// //
// //     final promotionNotificationRequest = promotionNotificationRequestFromJson(jsonString);
//
// import 'dart:convert';
//
// PromotionNotificationRequest promotionNotificationRequestFromJson(String str) =>
//     PromotionNotificationRequest.fromJson(json.decode(str));
//
// String promotionNotificationRequestToJson(PromotionNotificationRequest data) =>
//     json.encode(data.toJson());
//
// class PromotionNotificationRequest {
//   final int? page;
//   final int? size;
//
//   PromotionNotificationRequest({
//     this.page,
//     this.size,
//   });
//
//   factory PromotionNotificationRequest.fromJson(Map<String, dynamic> json) =>
//       PromotionNotificationRequest(
//         page: json["page"],
//         size: json["size"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "page": page,
//         "size": size,
//       };
// }

// To parse this JSON data, do
//
//     final promotionNotificationRequest = promotionNotificationRequestFromJson(jsonString);

import 'dart:convert';

PromotionNotificationRequest promotionNotificationRequestFromJson(String str) => PromotionNotificationRequest.fromJson(json.decode(str));

String promotionNotificationRequestToJson(PromotionNotificationRequest data) => json.encode(data.toJson());

class PromotionNotificationRequest {
  String? epicUserId;
  int? page;
  int? size;
  String? readStatus;

  PromotionNotificationRequest({
    this.epicUserId,
    this.page,
    this.size,
    this.readStatus,
  });

  factory PromotionNotificationRequest.fromJson(Map<String, dynamic> json) => PromotionNotificationRequest(
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
