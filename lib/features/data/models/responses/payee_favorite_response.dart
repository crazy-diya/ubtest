// To parse this JSON data, do
//
//     final payeeFavoriteResponse = payeeFavoriteResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

PayeeFavoriteResponse payeeFavoriteResponseFromJson(String str) => PayeeFavoriteResponse.fromJson(json.decode(str));

String payeeFavoriteResponseToJson(PayeeFavoriteResponse data) => json.encode(data.toJson());

class PayeeFavoriteResponse extends Serializable {
  int? id;

  PayeeFavoriteResponse({
    this.id,
  });

  factory PayeeFavoriteResponse.fromJson(Map<String, dynamic> json) => PayeeFavoriteResponse(
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
  };
}
