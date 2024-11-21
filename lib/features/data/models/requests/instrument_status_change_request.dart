// To parse this JSON data, do
//
//     final instrumentStatusChangeRequest = instrumentStatusChangeRequestFromJson(jsonString);

import 'dart:convert';

InstrumentStatusChangeRequest instrumentStatusChangeRequestFromJson(
        String str) =>
    InstrumentStatusChangeRequest.fromJson(json.decode(str));

String instrumentStatusChangeRequestToJson(
        InstrumentStatusChangeRequest data) =>
    json.encode(data.toJson());

class InstrumentStatusChangeRequest {
  InstrumentStatusChangeRequest({
    this.messageType,
    this.instrumentId,
  });

  String? messageType;
  int? instrumentId;

  factory InstrumentStatusChangeRequest.fromJson(Map<String, dynamic> json) =>
      InstrumentStatusChangeRequest(
        messageType: json["messageType"],
        instrumentId: json["instrumentId"],
      );

  Map<String, dynamic> toJson() => {
        "messageType": messageType,
        "instrumentId": instrumentId,
      };
}
