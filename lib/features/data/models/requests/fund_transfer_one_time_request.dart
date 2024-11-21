// To parse this JSON data, do
//
//     final oneTimeFundTransferRequest = oneTimeFundTransferRequestFromJson(jsonString);

import 'dart:convert';

OneTimeFundTransferRequest oneTimeFundTransferRequestFromJson(String str) =>
    OneTimeFundTransferRequest.fromJson(json.decode(str));

String oneTimeFundTransferRequestToJson(OneTimeFundTransferRequest data) =>
    json.encode(data.toJson());

class OneTimeFundTransferRequest {
  OneTimeFundTransferRequest({
    this.messageType,
  });

  String? messageType;

  factory OneTimeFundTransferRequest.fromJson(Map<String, dynamic> json) =>
      OneTimeFundTransferRequest(
        messageType: json["messageType"],
      );

  Map<String, dynamic> toJson() => {
        "messageType": messageType,
      };
}
