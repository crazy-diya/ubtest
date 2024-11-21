// To parse this JSON data, do
//
//     final requestCallBackGetResponse = requestCallBackGetResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

RequestCallBackGetResponse requestCallBackGetResponseFromJson(String str) => RequestCallBackGetResponse.fromJson(json.decode(str));

String requestCallBackGetResponseToJson(RequestCallBackGetResponse data) => json.encode(data.toJson());

class RequestCallBackGetResponse extends Serializable{
    final List<Response>? response;
    final int? count;

    RequestCallBackGetResponse({
        this.response,
        this.count,
    });

    factory RequestCallBackGetResponse.fromJson(Map<String, dynamic> json) => RequestCallBackGetResponse(
        response: json["response"] == null ? [] : List<Response>.from(json["response"]!.map((x) => Response.fromJson(x))),
        count: json["count"],
    );

    Map<String, dynamic> toJson() => {
        "response": response == null ? [] : List<dynamic>.from(response!.map((x) => x.toJson())),
        "count": count,
    };
}

class Response {
    final String? epicUserId;
    final String? callBackTime;
    final String? subject;
    final String? comment;
    final String? language;
    final DateTime? createDate;
    final DateTime? updateDate;
    final String? status;
    final int? id;

    Response({
        this.epicUserId,
        this.callBackTime,
        this.subject,
        this.comment,
        this.language,
        this.createDate,
        this.updateDate,
        this.status,
        this.id,
    });

    factory Response.fromJson(Map<String, dynamic> json) => Response(
        epicUserId: json["epicUserId"],
        callBackTime: json["callBackTime"],
        subject: json["subject"],
        comment: json["comment"],
        language: json["language"],
        createDate: json["createDate"] == null ? null : DateTime.parse(json["createDate"]),
        updateDate: json["updateDate"] == null ? null : DateTime.parse(json["updateDate"]),
        status: json["status"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "epicUserId": epicUserId,
        "callBackTime": callBackTime,
        "subject": subject,
        "comment": comment,
        "language": language,
        "createDate": createDate?.toIso8601String(),
        "updateDate": updateDate?.toIso8601String(),
        "status": status,
        "id": id,
    };
}
