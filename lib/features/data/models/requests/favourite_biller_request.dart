// To parse this JSON data, do
//
//     final favouriteBillerRequest = favouriteBillerRequestFromJson(jsonString);

import 'dart:convert';

FavouriteBillerRequest favouriteBillerRequestFromJson(String str) => FavouriteBillerRequest.fromJson(json.decode(str));

String favouriteBillerRequestToJson(FavouriteBillerRequest data) => json.encode(data.toJson());

//biller fav

class FavouriteBillerRequest {
  FavouriteBillerRequest({
    this.messageType,
    this.id,
    this.favourite,
  });

  final String? messageType;
  final int? id;
  final bool? favourite;

  factory FavouriteBillerRequest.fromJson(Map<String, dynamic> json) => FavouriteBillerRequest(
    messageType: json["messageType"],
    id: json["id"],
    favourite: json["favourite"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "id": id,
    "favourite": favourite,
  };
}
