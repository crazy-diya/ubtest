//
//
// import 'dart:convert';
//
// import 'package:union_bank_mobile/features/data/models/common/base_response.dart';
//
// PromotionNotificationResponse promotionNotificationResponseFromJson(String str) => PromotionNotificationResponse.fromJson(json.decode(str));
//
// String promotionNotificationResponseToJson(PromotionNotificationResponse data) => json.encode(data.toJson());
//
// class PromotionNotificationResponse extends Serializable{
//   final int? count;
//   final int? totalUnread;
//   final List<PromotionNotificationResponseDtoList>? userNotificationResponseDtoList;
//
//   PromotionNotificationResponse({
//     this.count,
//     this.totalUnread,
//     this.userNotificationResponseDtoList,
//   });
//
//   factory PromotionNotificationResponse.fromJson(Map<String, dynamic> json) => PromotionNotificationResponse(
//     count: json["count"],
//     totalUnread: json["totalUnread"],
//     userNotificationResponseDtoList: json["userNotificationResponseDTOList"] == null ? [] : List<PromotionNotificationResponseDtoList>.from(json["userNotificationResponseDTOList"]!.map((x) => PromotionNotificationResponseDtoList.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "count": count,
//     "totalUnread": totalUnread,
//     "userNotificationResponseDTOList": userNotificationResponseDtoList == null ? [] : List<dynamic>.from(userNotificationResponseDtoList!.map((x) => x.toJson())),
//   };
// }
//
// class PromotionNotificationResponseDtoList {
//   final int? readStatus;
//   final int notificationId;
//   final String promoImage;
//   final String promoHeader;
//   final String promoBody;
//   final String offerValidTill;
//   final List<dynamic> category;
//   final DateTime createdDate;
//
//   PromotionNotificationResponseDtoList({
//     this.readStatus,
//     required this.notificationId,
//     required this.promoImage,
//     required this.promoHeader,
//     required this.promoBody,
//     required this.offerValidTill,
//     required this.category,
//     required this.createdDate,
//   });
//
//   factory PromotionNotificationResponseDtoList.fromJson(Map<String, dynamic> json) => PromotionNotificationResponseDtoList(
//     readStatus: json["readStatus"],
//     notificationId: json["notificationId"],
//     promoImage: json["promoImage"],
//     promoHeader: json["promoHeader"],
//     promoBody: json["promoBody"],
//     offerValidTill: json["offerValidTill"],
//     category: json["category"] == null ? [] : List<dynamic>.from(json["category"]!.map((x) => x)),
//     createdDate: DateTime.parse(json["createdDate"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "readStatus": readStatus,
//     "notificationId": notificationId,
//     "promoImage": promoImage,
//     "promoHeader": promoHeader,
//     "promoBody": promoBody,
//     "offerValidTill": offerValidTill,
//     "category": category == null ? [] : List<dynamic>.from(category!.map((x) => x)),
//     "createdDate": createdDate.toIso8601String(),  };
// }

// To parse this JSON data, do
//
//     final promotionNotificationResponse = promotionNotificationResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

PromotionNotificationResponse promotionNotificationResponseFromJson(String str) => PromotionNotificationResponse.fromJson(json.decode(str));

String promotionNotificationResponseToJson(PromotionNotificationResponse data) => json.encode(data.toJson());

class PromotionNotificationResponse extends Serializable{
  final int? count;
  final int? totalUnread;
  final List<PromotionNotificationResponseDtoList>? userNotificationResponseDtoList;

  PromotionNotificationResponse({
    this.count,
    this.totalUnread,
    this.userNotificationResponseDtoList,
  });

  factory PromotionNotificationResponse.fromJson(Map<String, dynamic> json) => PromotionNotificationResponse(
    count: json["count"],
    totalUnread: json["totalUnread"],
    userNotificationResponseDtoList: json["userNotificationResponseDTOList"] == null ? [] : List<PromotionNotificationResponseDtoList>.from(json["userNotificationResponseDTOList"]!.map((x) => PromotionNotificationResponseDtoList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "totalUnread": totalUnread,
    "userNotificationResponseDTOList": userNotificationResponseDtoList == null ? [] : List<dynamic>.from(userNotificationResponseDtoList!.map((x) => x.toJson())),
  };
}

class PromotionNotificationResponseDtoList {
  final int? readStatus;
  final int? notificationId;
  final List<String>? promoImage;
  final String? promoHeader;
  final String? promoIcon;
  final String? promoBody;
  final String? offerValidTill;
  final String? channel;
  final List<dynamic>? category;
  final DateTime? createdDate;

  PromotionNotificationResponseDtoList({
    this.readStatus,
    this.notificationId,
    this.promoImage,
    this.promoHeader,
    this.promoIcon,
    this.promoBody,
    this.offerValidTill,
    this.channel,
    this.category,
    this.createdDate,
  });

  factory PromotionNotificationResponseDtoList.fromJson(Map<String, dynamic> json) => PromotionNotificationResponseDtoList(
    readStatus: json["readStatus"],
    notificationId: json["notificationId"],
    promoImage: json["promoImage"] == null ? [] : List<String>.from(json["promoImage"]!.map((x) => x)),
    promoHeader: json["promoHeader"],
    promoIcon: json["promoIcon"],
    promoBody: json["promoBody"],
    offerValidTill: json["offerValidTill"],
    channel: json["channel"],
    category: json["category"] == null ? [] : List<dynamic>.from(json["category"]!.map((x) => x)),
    createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
  );

  Map<String, dynamic> toJson() => {
    "readStatus": readStatus,
    "notificationId": notificationId,
    "promoImage": promoImage == null ? [] : List<dynamic>.from(promoImage!.map((x) => x)),
    "promoHeader": promoHeader,
    "promoIcon": promoIcon,
    "promoBody": promoBody,
    "offerValidTill": offerValidTill,
    "channel": channel,
    "category": category == null ? [] : List<dynamic>.from(category!.map((x) => x)),
    "createdDate": createdDate?.toIso8601String(),
  };
}
