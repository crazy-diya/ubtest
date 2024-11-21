// To parse this JSON data, do
//
//     final initiateItransfertResponse = initiateItransfertResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

InitiateItransfertResponse initiateItransfertResponseFromJson(String str) => InitiateItransfertResponse.fromJson(json.decode(str));

String initiateItransfertResponseToJson(InitiateItransfertResponse data) => json.encode(data.toJson());

class InitiateItransfertResponse extends Serializable {
  String? theme;
  int? instrumentId;
  String? toPayeeName;
  String? toPayeeMobile;
  String? toPayeeEmail;
  String? amount;
  String? message;
  DateTime? dateTime;
  String? referenceId;
  String? shareLink;

  InitiateItransfertResponse({
    this.theme,
    this.instrumentId,
    this.toPayeeName,
    this.toPayeeMobile,
    this.toPayeeEmail,
    this.amount,
    this.message,
    this.dateTime,
    this.referenceId,
    this.shareLink,
  });

  factory InitiateItransfertResponse.fromJson(Map<String, dynamic> json) => InitiateItransfertResponse(
    theme: json["theme"],
    instrumentId: json["instrumentId"],
    toPayeeName: json["toPayeeName"],
    toPayeeMobile: json["toPayeeMobile"],
    toPayeeEmail: json["toPayeeEmail"],
    amount: json["amount"],
    message: json["message"],
    dateTime: DateTime.parse(json["dateTime"]),
    referenceId: json["referenceId"],
    shareLink: json["shareLink"],
  );

  Map<String, dynamic> toJson() => {
    "theme": theme,
    "instrumentId": instrumentId,
    "toPayeeName": toPayeeName,
    "toPayeeMobile": toPayeeMobile,
    "toPayeeEmail": toPayeeEmail,
    "amount": amount,
    "message": message,
    "dateTime": dateTime!.toIso8601String(),
    "referenceId": referenceId,
    "shareLink": shareLink,
  };
}
