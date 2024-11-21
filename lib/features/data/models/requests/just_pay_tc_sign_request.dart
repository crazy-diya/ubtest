// To parse this JSON data, do
//
//     final justpayTCSignRequest = justpayTcSignRequestFromJson(jsonString);

import 'dart:convert';

JustpayTCSignRequest justpayTcSignRequestFromJson(String str) => JustpayTCSignRequest.fromJson(json.decode(str));

String justpayTcSignRequestToJson(JustpayTCSignRequest data) => json.encode(data.toJson());

class JustpayTCSignRequest {
    final String? challengeId;
    final String? termAndCondition;
    final String? messageType;

    JustpayTCSignRequest({
        this.messageType,
        this.challengeId,
        this.termAndCondition,
    });

    factory JustpayTCSignRequest.fromJson(Map<String, dynamic> json) => JustpayTCSignRequest(
        messageType: json["messageType"],
        challengeId: json["challengeId"],
        termAndCondition: json["termAndCondition"],
    );

    Map<String, dynamic> toJson() => {
        "messageType": messageType,
        "challengeId": challengeId,
        "termAndCondition": termAndCondition,
    };
}
