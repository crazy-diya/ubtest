// To parse this JSON data, do
//
//     final requestCallBackGetRequest = requestCallBackGetRequestFromJson(jsonString);

import 'dart:convert';

RequestCallBackGetRequest requestCallBackGetRequestFromJson(String str) => RequestCallBackGetRequest.fromJson(json.decode(str));

String requestCallBackGetRequestToJson(RequestCallBackGetRequest data) => json.encode(data.toJson());

class RequestCallBackGetRequest {
    final String? epicUserId;
    final int? page;
    final int? size;
    final DateTime? fromDate;
    final DateTime? toDate;
    final String? status;
    final int? subject;

    RequestCallBackGetRequest({
        this.epicUserId,
        this.page,
        this.size,
        this.fromDate,
        this.toDate,
        this.status,
        this.subject,
    });

    factory RequestCallBackGetRequest.fromJson(Map<String, dynamic> json) => RequestCallBackGetRequest(
        epicUserId: json["epicUser_id"],
        page: json["page"],
        fromDate: json["fromDate"],
        size: json["size"],
        toDate: json["toDate"],
        status: json["status"],
        subject: json["subject"],
    );

    Map<String, dynamic> toJson() => {
        "epicUser_id": epicUserId,
        "page": page,
        "size": size,
        "fromDate": fromDate?.toIso8601String(),
        "toDate": toDate?.toIso8601String(),
        "status": status,
        "subject": subject,
    };
}
