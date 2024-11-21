// To parse this JSON data, do
//
//     final promotionShareResponse = promotionShareResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

PromotionShareResponse promotionShareResponseFromJson(String str) => PromotionShareResponse.fromJson(json.decode(str));

String promotionShareResponseToJson(PromotionShareResponse data) => json.encode(data.toJson());

class PromotionShareResponse extends Serializable {
  String? document;

  PromotionShareResponse({
    this.document,
  });

  factory PromotionShareResponse.fromJson(Map<String, dynamic> json) =>
      PromotionShareResponse(
        document: json["document"],
      );

  Map<String, dynamic> toJson() => {
        "document": document,
  };
}
