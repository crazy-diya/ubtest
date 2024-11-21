
import 'dart:convert';

import '../../../common/base_response.dart';

CardLoyaltyVouchersResponse cardLoyaltyPointsResponseFromJson(String str) => CardLoyaltyVouchersResponse.fromJson(json.decode(str));

String cardLoyaltyPointsResponseToJson(CardLoyaltyVouchersResponse data) => json.encode(data.toJson());

class CardLoyaltyVouchersResponse  extends Serializable{
  List<CardLoyaltyList>? cardLoyaltyList;
  int? minLoyaltyPoints;

  CardLoyaltyVouchersResponse({
    this.cardLoyaltyList,
    this.minLoyaltyPoints,
  });

  factory CardLoyaltyVouchersResponse.fromJson(Map<String, dynamic> json) => CardLoyaltyVouchersResponse(
    cardLoyaltyList: json["cardLoyaltyList"] == null ? [] : List<CardLoyaltyList>.from(json["cardLoyaltyList"]!.map((x) => CardLoyaltyList.fromJson(x))),
      minLoyaltyPoints: json["minLoyaltyPoints"]
  );

  Map<String, dynamic> toJson() => {
    "cardLoyaltyList": cardLoyaltyList == null ? [] : List<dynamic>.from(cardLoyaltyList!.map((x) => x.toJson())),
    "minLoyaltyPoints" : minLoyaltyPoints
  };
}

class CardLoyaltyList {
  int? id;
  String? code;
  String? channel;
  String? ibDescription;
  String? mbDescription;
  String? status;
  num? pointValue;
  num? qtyTotal;
  num? qtyAvailable;
  DateTime? startDate;
  DateTime? endDate;
  DateTime? modifiedDate;
  DateTime? createdDate;

  CardLoyaltyList({
    this.id,
    this.code,
    this.channel,
    this.ibDescription,
    this.mbDescription,
    this.status,
    this.pointValue,
    this.qtyTotal,
    this.qtyAvailable,
    this.startDate,
    this.endDate,
    this.modifiedDate,
    this.createdDate,
  });

  factory CardLoyaltyList.fromJson(Map<String, dynamic> json) => CardLoyaltyList(
    id: json["id"],
    code: json["code"],
    channel: json["channel"],
    ibDescription: json["ibDescription"],
    mbDescription: json["mbDescription"],
    status: json["status"],
    pointValue: json["pointValue"],
    qtyTotal: json["qtyTotal"],
    qtyAvailable: json["qtyAvailable"],
    startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
    endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
    modifiedDate: json["modifiedDate"] == null ? null : DateTime.parse(json["modifiedDate"]),
    createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "channel": channel,
    "ibDescription": ibDescription,
    "mbDescription": mbDescription,
    "status": status,
    "pointValue": pointValue,
    "qtyTotal": qtyTotal,
    "qtyAvailable": qtyAvailable,
    "startDate": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
    "endDate": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
    "modifiedDate": "${modifiedDate!.year.toString().padLeft(4, '0')}-${modifiedDate!.month.toString().padLeft(2, '0')}-${modifiedDate!.day.toString().padLeft(2, '0')}",
    "createdDate": "${createdDate!.year.toString().padLeft(4, '0')}-${createdDate!.month.toString().padLeft(2, '0')}-${createdDate!.day.toString().padLeft(2, '0')}",
  };
}


// To parse this JSON data, do
//
//     final cardLoyaltyVouchersResponse = cardLoyaltyVouchersResponseFromJson(jsonString);

// To parse this JSON data, do
//
//     final cardLoyaltyVouchersResponse = cardLoyaltyVouchersResponseFromJson(jsonString);

// import 'dart:convert';
//
// import 'package:union_bank_mobile/features/data/models/common/base_response.dart';
//
// CardLoyaltyVouchersResponse cardLoyaltyVouchersResponseFromJson(String str) => CardLoyaltyVouchersResponse.fromJson(json.decode(str));
//
// String cardLoyaltyVouchersResponseToJson(CardLoyaltyVouchersResponse data) => json.encode(data.toJson());
//
// class CardLoyaltyVouchersResponse extends Serializable{
//   final Data? data;
//
//   CardLoyaltyVouchersResponse({
//     this.data,
//   });
//
//   factory CardLoyaltyVouchersResponse.fromJson(Map<String, dynamic> json) => CardLoyaltyVouchersResponse(
//     data: json["data"] == null ? null : Data.fromJson(json["data"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "data": data?.toJson(),
//   };
// }
//
// class Data {
//   final List<CardLoyaltyList>? cardLoyaltyList;
//   final int? minLoyaltyPoints;
//
//   Data({
//     this.cardLoyaltyList,
//     this.minLoyaltyPoints,
//   });
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     cardLoyaltyList: json["cardLoyaltyList"] == null ? [] : List<CardLoyaltyList>.from(json["cardLoyaltyList"]!.map((x) => CardLoyaltyList.fromJson(x))),
//     minLoyaltyPoints: json["minLoyaltyPoints"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "cardLoyaltyList": cardLoyaltyList == null ? [] : List<dynamic>.from(cardLoyaltyList!.map((x) => x.toJson())),
//     "minLoyaltyPoints": minLoyaltyPoints,
//   };
// }
//
// class CardLoyaltyList {
//   final int? id;
//   final String? code;
//   final String? ibDescription;
//   final String? mbDescription;
//   final String? status;
//   final int? pointValue;
//   final int? qtyTotal;
//   final int? qtyAvailable;
//   final DateTime? startDate;
//   final DateTime? endDate;
//   final String? modifiedUser;
//   final DateTime? modifiedDate;
//   final String? createdUser;
//   final DateTime? createdDate;
//
//   CardLoyaltyList({
//     this.id,
//     this.code,
//     this.ibDescription,
//     this.mbDescription,
//     this.status,
//     this.pointValue,
//     this.qtyTotal,
//     this.qtyAvailable,
//     this.startDate,
//     this.endDate,
//     this.modifiedUser,
//     this.modifiedDate,
//     this.createdUser,
//     this.createdDate,
//   });
//
//   factory CardLoyaltyList.fromJson(Map<String, dynamic> json) => CardLoyaltyList(
//     id: json["id"],
//     code: json["code"],
//     ibDescription: json["ibDescription"],
//     mbDescription: json["mbDescription"],
//     status: json["status"],
//     pointValue: json["pointValue"],
//     qtyTotal: json["qtyTotal"],
//     qtyAvailable: json["qtyAvailable"],
//     startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
//     endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
//     modifiedUser: json["modifiedUser"],
//     modifiedDate: json["modifiedDate"] == null ? null : DateTime.parse(json["modifiedDate"]),
//     createdUser: json["createdUser"],
//     createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "code": code,
//     "ibDescription": ibDescription,
//     "mbDescription": mbDescription,
//     "status": status,
//     "pointValue": pointValue,
//     "qtyTotal": qtyTotal,
//     "qtyAvailable": qtyAvailable,
//     "startDate": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
//     "endDate": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
//     "modifiedUser": modifiedUser,
//     "modifiedDate": "${modifiedDate!.year.toString().padLeft(4, '0')}-${modifiedDate!.month.toString().padLeft(2, '0')}-${modifiedDate!.day.toString().padLeft(2, '0')}",
//     "createdUser": createdUser,
//     "createdDate": "${createdDate!.year.toString().padLeft(4, '0')}-${createdDate!.month.toString().padLeft(2, '0')}-${createdDate!.day.toString().padLeft(2, '0')}",
//   };
// }
