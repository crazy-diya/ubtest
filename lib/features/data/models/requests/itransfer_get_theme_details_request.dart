// To parse this JSON data, do
//
//     final itransferGetThemeDetailsRequest = itransferGetThemeDetailsRequestFromJson(jsonString);

import 'dart:convert';

ItransferGetThemeDetailsRequest itransferGetThemeDetailsRequestFromJson(String str) => ItransferGetThemeDetailsRequest.fromJson(json.decode(str));

String itransferGetThemeDetailsRequestToJson(ItransferGetThemeDetailsRequest data) => json.encode(data.toJson());

class ItransferGetThemeDetailsRequest {
  ItransferGetThemeDetailsRequest({
    this.messageType,
    this.id,
  });

  String? messageType;
  int? id;

  factory ItransferGetThemeDetailsRequest.fromJson(Map<String, dynamic> json) => ItransferGetThemeDetailsRequest(
    messageType: json["messageType"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "id": id,
  };
}
