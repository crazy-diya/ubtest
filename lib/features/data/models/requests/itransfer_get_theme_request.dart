// To parse this JSON data, do
//
//     final itransferGetThemeRequest = itransferGetThemeRequestFromJson(jsonString);

import 'dart:convert';

ItransferGetThemeRequest itransferGetThemeRequestFromJson(String str) => ItransferGetThemeRequest.fromJson(json.decode(str));

String itransferGetThemeRequestToJson(ItransferGetThemeRequest data) => json.encode(data.toJson());

class ItransferGetThemeRequest {
  ItransferGetThemeRequest({
    this.messageType,
  });

  String? messageType;

  factory ItransferGetThemeRequest.fromJson(Map<String, dynamic> json) => ItransferGetThemeRequest(
    messageType: json["messageType"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
  };
}
