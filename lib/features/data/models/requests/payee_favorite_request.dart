// To parse this JSON data, do
//
//     final payeeFavoriteRequest = payeeFavoriteRequestFromJson(jsonString);

import 'dart:convert';

PayeeFavoriteRequest payeeFavoriteRequestFromJson(String str) => PayeeFavoriteRequest.fromJson(json.decode(str));

String payeeFavoriteRequestToJson(PayeeFavoriteRequest data) => json.encode(data.toJson());

class PayeeFavoriteRequest {
  String? messageType;
  int? id;
  bool? favourite;

  PayeeFavoriteRequest({
    this.messageType,
    this.id,
    this.favourite,
  });

  factory PayeeFavoriteRequest.fromJson(Map<String, dynamic> json) => PayeeFavoriteRequest(
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
