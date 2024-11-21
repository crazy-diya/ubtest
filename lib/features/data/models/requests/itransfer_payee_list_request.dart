// To parse this JSON data, do
//
//     final itransferPayeeListRequest = itransferPayeeListRequestFromJson(jsonString);

import 'dart:convert';

ItransferPayeeListRequest itransferPayeeListRequestFromJson(String str) =>
    ItransferPayeeListRequest.fromJson(json.decode(str));

String itransferPayeeListRequestToJson(ItransferPayeeListRequest data) =>
    json.encode(data.toJson());

class ItransferPayeeListRequest {
  ItransferPayeeListRequest({
    this.messageType,
  });

  String? messageType;

  factory ItransferPayeeListRequest.fromJson(Map<String, dynamic> json) =>
      ItransferPayeeListRequest(
        messageType: json["messageType"],
      );

  Map<String, dynamic> toJson() => {
        "messageType": messageType,
      };
}
