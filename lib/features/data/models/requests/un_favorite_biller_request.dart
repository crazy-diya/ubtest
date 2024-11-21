// To parse this JSON data, do
//
//     final unFavoriteBillerRequest = unFavoriteBillerRequestFromJson(jsonString);

import 'dart:convert';

UnFavoriteBillerRequest unFavoriteBillerRequestFromJson(String str) => UnFavoriteBillerRequest.fromJson(json.decode(str));

String unFavoriteBillerRequestToJson(UnFavoriteBillerRequest data) => json.encode(data.toJson());

class UnFavoriteBillerRequest {
  UnFavoriteBillerRequest({
    this.messageType,
    this.billerId,
  });

  String? messageType;
  int? billerId;

  factory UnFavoriteBillerRequest.fromJson(Map<String, dynamic> json) => UnFavoriteBillerRequest(
    messageType: json["messageType"],
    billerId: json["billerId"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "billerId": billerId,
  };
}
