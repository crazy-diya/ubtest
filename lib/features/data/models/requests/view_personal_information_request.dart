// To parse this JSON data, do
//
//     final viewPersonalInformationRequest = viewPersonalInformationRequestFromJson(jsonString);

import 'dart:convert';

ViewPersonalInformationRequest viewPersonalInformationRequestFromJson(
        String str) =>
    ViewPersonalInformationRequest.fromJson(json.decode(str));

String viewPersonalInformationRequestToJson(
        ViewPersonalInformationRequest data) =>
    json.encode(data.toJson());

class ViewPersonalInformationRequest {
  ViewPersonalInformationRequest({
    this.messageType,
  });

  String? messageType;

  factory ViewPersonalInformationRequest.fromJson(Map<String, dynamic> json) =>
      ViewPersonalInformationRequest(
        messageType: json["messageType"],
      );

  Map<String, dynamic> toJson() => {
        "messageType": messageType,
      };
}
