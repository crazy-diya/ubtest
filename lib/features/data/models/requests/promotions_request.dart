// To parse this JSON data, do
//
//     final promotionsRequest = promotionsRequestFromJson(jsonString);

import 'dart:convert';

PromotionsRequest promotionsRequestFromJson(String str) => PromotionsRequest.fromJson(json.decode(str));

String promotionsRequestToJson(PromotionsRequest data) => json.encode(data.toJson());

class PromotionsRequest {
  String? messageType;
  String? isHome;
  String? fromDate;
  String? toDate;

  PromotionsRequest({
    this.messageType,
    this.isHome,
    this.fromDate,
    this.toDate,
  });

  factory PromotionsRequest.fromJson(Map<String, dynamic> json) => PromotionsRequest(
    messageType: json["messageType"],
    isHome: json["isHome"],
    fromDate: json["fromDate"],
    toDate: json["toDate"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "isHome": isHome,
    "fromDate": fromDate,
    "toDate": toDate,
  };
}
