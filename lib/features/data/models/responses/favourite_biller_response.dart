// To parse this JSON data, do
//
//     final favoriteBillerResponse = favoriteBillerResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

FavoriteBillerResponse favoriteBillerResponseFromJson(String str) => FavoriteBillerResponse.fromJson(json.decode(str));

String favoriteBillerResponseToJson(FavoriteBillerResponse data) => json.encode(data.toJson());

class FavoriteBillerResponse extends Serializable {
  int? id;

  FavoriteBillerResponse({
    this.id,
  });

  factory FavoriteBillerResponse.fromJson(Map<String, dynamic> json) => FavoriteBillerResponse(
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
  };
}
