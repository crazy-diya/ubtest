// To parse this JSON data, do
//
//     final serviceReqHistoryRequest = serviceReqHistoryRequestFromJson(jsonString);

import 'dart:convert';

ServiceReqHistoryRequest serviceReqHistoryRequestFromJson(String str) => ServiceReqHistoryRequest.fromJson(json.decode(str));

String serviceReqHistoryRequestToJson(ServiceReqHistoryRequest data) => json.encode(data.toJson());

class ServiceReqHistoryRequest {
  ServiceReqHistoryRequest({
    this.messageType,
    this.fromDate,
    this.toDate,
    this.requestType,
  });

  String? messageType;
  String? fromDate;
  String? toDate;
  String? requestType;

  factory ServiceReqHistoryRequest.fromJson(Map<String, dynamic> json) => ServiceReqHistoryRequest(
    messageType: json["messageType"],
    fromDate: json["fromDate"],
    toDate: json["toDate"],
    requestType: json["requestType"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "fromDate": fromDate,
    "toDate": toDate,
    "requestType": requestType,
  };
}
