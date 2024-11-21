// To parse this JSON data, do
//
//     final reqMoneyNotificationHistoryRequest = reqMoneyNotificationHistoryRequestFromJson(jsonString);

import 'dart:convert';

ReqMoneyNotificationHistoryRequest reqMoneyNotificationHistoryRequestFromJson(String str) => ReqMoneyNotificationHistoryRequest.fromJson(json.decode(str));

String reqMoneyNotificationHistoryRequestToJson(ReqMoneyNotificationHistoryRequest data) => json.encode(data.toJson());

class ReqMoneyNotificationHistoryRequest {
  final String? messageType;
  final String? requestMoneyId;
  final String? status;
  final String? transactionStatus;
  final String? transactionId;

  ReqMoneyNotificationHistoryRequest({
    this.messageType,
    this.requestMoneyId,
    this.status,
    this.transactionStatus,
    this.transactionId,
  });

  factory ReqMoneyNotificationHistoryRequest.fromJson(Map<String, dynamic> json) => ReqMoneyNotificationHistoryRequest(
    messageType: json["messageType"],
    requestMoneyId: json["requestMoneyId"],
    status: json["status"],
    transactionStatus: json["transactionStatus"],
    transactionId: json["transactionId"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "requestMoneyId": requestMoneyId,
    "status": status,
    "transactionStatus": transactionStatus,
    "transactionId": transactionId,
  };
}
