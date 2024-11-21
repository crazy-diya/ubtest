// To parse this JSON data, do
//
//     final serviceReqHistoryResponse = serviceReqHistoryResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

ServiceReqHistoryResponse serviceReqHistoryResponseFromJson(String str) => ServiceReqHistoryResponse.fromJson(json.decode(str));

String serviceReqHistoryResponseToJson(ServiceReqHistoryResponse data) => json.encode(data.toJson());

class ServiceReqHistoryResponse extends Serializable {
  List<RequestList>? requestList;

  ServiceReqHistoryResponse({
    this.requestList,
  });

  factory ServiceReqHistoryResponse.fromJson(Map<String, dynamic> json) => ServiceReqHistoryResponse(
    requestList:json["requestList"] != null? List<RequestList>.from(json["requestList"].map((x) => RequestList.fromJson(x))):List.empty(),
  );

  Map<String, dynamic> toJson() => {
    "requestList": List<dynamic>.from(requestList!.map((x) => x.toJson())),
  };
}

class RequestList {
  String? requestType;
  String? referenceNumber;
  String? requestedDate;
  String? status;
  String? rejectReason;

  RequestList({
    this.requestType,
    this.referenceNumber,
    this.requestedDate,
    this.status,
    this.rejectReason,
  });

  factory RequestList.fromJson(Map<String, dynamic> json) => RequestList(
    requestType: json["requestType"]??"",
    referenceNumber: json["referenceNumber"]??"",
    requestedDate: json["requestedDate"],
    status: json["status"]??"",
    rejectReason: json["rejectReason"]??"",
  );

  Map<String, dynamic> toJson() => {
    "requestType": requestType,
    "referenceNumber": referenceNumber,
    "requestedDate": requestedDate,
    "status": status,
    "rejectReason": rejectReason,
  };
}
