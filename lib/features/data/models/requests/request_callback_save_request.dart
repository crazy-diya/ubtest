// To parse this JSON data, do
//
//     final requestCallBackSaveRequest = requestCallBackSaveRequestFromJson(jsonString);

import 'dart:convert';

RequestCallBackSaveRequest requestCallBackSaveRequestFromJson(String str) => RequestCallBackSaveRequest.fromJson(json.decode(str));

String requestCallBackSaveRequestToJson(RequestCallBackSaveRequest data) => json.encode(data.toJson());

class RequestCallBackSaveRequest {
    final String? epicUserId;
    final String? callBackTime;
    final String? subject;
    final String? language;
    final String? comment;

    RequestCallBackSaveRequest({
        this.epicUserId,
        this.callBackTime,
        this.subject,
        this.language,
        this.comment,
    });

    factory RequestCallBackSaveRequest.fromJson(Map<String, dynamic> json) => RequestCallBackSaveRequest(
        epicUserId: json["epicUser_id"],
        callBackTime: json["callBackTime"],
        subject: json["subject"],
        language: json["language"],
        comment: json["comment"],
    );

    Map<String, dynamic> toJson() => {
        "epicUser_id": epicUserId,
        "callBackTime": callBackTime,
        "subject": subject,
        "language": language,
        "comment": comment,
    };
}
