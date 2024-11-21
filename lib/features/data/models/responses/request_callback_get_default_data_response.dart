
import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

RequestCallBackGetDefaultDataResponse requestCallBackGetDefaultDataResponseFromJson(String str) => RequestCallBackGetDefaultDataResponse.fromJson(json.decode(str));

String requestCallBackGetDefaultDataResponseToJson(RequestCallBackGetDefaultDataResponse data) => json.encode(data.toJson());

class RequestCallBackGetDefaultDataResponse extends Serializable{
    final List<RequestDetailDefaultDataTimeSlotResponseList>? requestDetailDefaultDataTimeSlotResponseList;
    final List<RequestDetailDefaultDataSubjectResponse>? requestDetailDefaultDataSubjectResponses;
    final List<StatusList>? statusList;

    RequestCallBackGetDefaultDataResponse({
        this.requestDetailDefaultDataTimeSlotResponseList,
        this.requestDetailDefaultDataSubjectResponses,
        this.statusList,
    });

    factory RequestCallBackGetDefaultDataResponse.fromJson(Map<String, dynamic> json) => RequestCallBackGetDefaultDataResponse(
        requestDetailDefaultDataTimeSlotResponseList: json["requestDetailDefaultDataTimeSlotResponseList"] == null ? [] : List<RequestDetailDefaultDataTimeSlotResponseList>.from(json["requestDetailDefaultDataTimeSlotResponseList"]!.map((x) => RequestDetailDefaultDataTimeSlotResponseList.fromJson(x))),
        requestDetailDefaultDataSubjectResponses: json["requestDetailDefaultDataSubjectResponses"] == null ? [] : List<RequestDetailDefaultDataSubjectResponse>.from(json["requestDetailDefaultDataSubjectResponses"]!.map((x) => RequestDetailDefaultDataSubjectResponse.fromJson(x))),
        statusList: json["statusList"] == null ? [] : List<StatusList>.from(json["statusList"]!.map((x) => StatusList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "requestDetailDefaultDataTimeSlotResponseList": requestDetailDefaultDataTimeSlotResponseList == null ? [] : List<dynamic>.from(requestDetailDefaultDataTimeSlotResponseList!.map((x) => x.toJson())),
        "requestDetailDefaultDataSubjectResponses": requestDetailDefaultDataSubjectResponses == null ? [] : List<dynamic>.from(requestDetailDefaultDataSubjectResponses!.map((x) => x.toJson())),
        "statusList": statusList == null ? [] : List<dynamic>.from(statusList!.map((x) => x.toJson())),
    };
}

class RequestDetailDefaultDataSubjectResponse {
    final int? id;
    final String? subjectCode;
    final String? subjectName;

    RequestDetailDefaultDataSubjectResponse({
        this.id,
        this.subjectCode,
        this.subjectName,
    });

    factory RequestDetailDefaultDataSubjectResponse.fromJson(Map<String, dynamic> json) => RequestDetailDefaultDataSubjectResponse(
        id: json["id"],
        subjectCode: json["subjectCode"],
        subjectName: json["subjectName"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "subjectCode": subjectCode,
        "subjectName": subjectName,
    };
}

class RequestDetailDefaultDataTimeSlotResponseList {
    final int? id;
    final String? slotCode;
    final String? slotName;

    RequestDetailDefaultDataTimeSlotResponseList({
        this.id,
        this.slotCode,
        this.slotName,
    });

    factory RequestDetailDefaultDataTimeSlotResponseList.fromJson(Map<String, dynamic> json) => RequestDetailDefaultDataTimeSlotResponseList(
        id: json["id"],
        slotCode: json["slotCode"],
        slotName: json["slotName"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "slotCode": slotCode,
        "slotName": slotName,
    };
}

class StatusList {
    final String? status;
    final String? description;

    StatusList({
        this.status,
        this.description,
    });

    factory StatusList.fromJson(Map<String, dynamic> json) => StatusList(
        status: json["status"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "description": description,
    };
}

