// To parse this JSON data, do
//
//     final serviceReqFilteredListRespose = serviceReqFilteredListResposeFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

ServiceReqFilteredListResponse serviceReqFilteredListResponseFromJson(String str) => ServiceReqFilteredListResponse.fromJson(json.decode(str));

String serviceReqFilteredListResponseToJson(ServiceReqFilteredListResponse data) => json.encode(data.toJson());

class ServiceReqFilteredListResponse extends Serializable {
  ServiceReqFilteredListResponse({
    this.requestType,
    this.results,
  });

  String? requestType;
  List<List<ServiceReqFilteredList>>? results;

  factory ServiceReqFilteredListResponse.fromJson(Map<String, dynamic> json) => ServiceReqFilteredListResponse(
    requestType: json["requestType"],
    results:json["results"] != null ? List<List<ServiceReqFilteredList>>.from(json["results"].map((x) => List<ServiceReqFilteredList>.from(x.map((x) => ServiceReqFilteredList.fromJson(x))))):[]
  );

  Map<String, dynamic> toJson() => {
    "requestType": requestType,
    "results": List<dynamic>.from(results!.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
  };
}

class ServiceReqFilteredList {
  ServiceReqFilteredList({
    this.id,
    this.createdDate,
    this.embossingName,
    this.status,
    this.rejectReason,
  });

  int? id;
  String? createdDate;
  String? embossingName;
  String? status;
  String? rejectReason;

  factory ServiceReqFilteredList.fromJson(Map<String, dynamic> json) => ServiceReqFilteredList(
    id: json["id"],
    createdDate: json["createdDate"],
    embossingName: json["embossingName"],
    status: json["status"],
    rejectReason: json["rejectReason"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "createdDate": createdDate,
    "embossingName": embossingName,
    "status": status,
    "rejectReason":rejectReason,
  };
}


