// To parse this JSON data, do
//
//     final promotionShareRequest = promotionShareRequestFromJson(jsonString);

import 'dart:convert';

PromotionShareRequest promotionShareRequestFromJson(String str) => PromotionShareRequest.fromJson(json.decode(str));

String promotionShareRequestToJson(PromotionShareRequest data) => json.encode(data.toJson());

class PromotionShareRequest {
  String promotionId;
  String messageType;

  PromotionShareRequest({
    required this.promotionId,
    required this.messageType,
  });

  factory PromotionShareRequest.fromJson(Map<String, dynamic> json) => PromotionShareRequest(
    promotionId: json["promotionId"],
    messageType: json["messageType"],
  );

  Map<String, dynamic> toJson() => {
    "promotionId": promotionId,
    "messageType": messageType,
  };
}
