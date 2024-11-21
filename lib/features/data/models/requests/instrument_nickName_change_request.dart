// To parse this JSON data, do
//
//     final instrumentNickNameChangeRequest = instrumentNickNameChangeRequestFromJson(jsonString);

import 'dart:convert';

InstrumentNickNameChangeRequest instrumentNickNameChangeRequestFromJson(
    String str) =>
    InstrumentNickNameChangeRequest.fromJson(json.decode(str));

String instrumentNickNameChangeRequestToJson(
    InstrumentNickNameChangeRequest data) =>
    json.encode(data.toJson());

class InstrumentNickNameChangeRequest {
  InstrumentNickNameChangeRequest({
    this.messageType,
    this.instrumentId,
    this.nickName,
    this.instrumentType,
  });

  String? messageType;
  int? instrumentId;
  String? nickName;
  String? instrumentType;

  factory InstrumentNickNameChangeRequest.fromJson(Map<String, dynamic> json) =>
      InstrumentNickNameChangeRequest(
          messageType: json["messageType"],
          instrumentId: json["instrumentId"],
          nickName: json["nickName"],
          instrumentType: json["instrumentType"]
      );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "instrumentId": instrumentId,
    "nickName": nickName,
    "instrumentType":instrumentType,
  };
}
