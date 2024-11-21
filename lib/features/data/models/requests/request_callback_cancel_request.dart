// To parse this JSON data, do
//
//     final requestCallBackCancelRequest = requestCallBackCancelRequestFromJson(jsonString);

import 'dart:convert';

RequestCallBackCancelRequest requestCallBackCancelRequestFromJson(String str) => RequestCallBackCancelRequest.fromJson(json.decode(str));

String requestCallBackCancelRequestToJson(RequestCallBackCancelRequest data) => json.encode(data.toJson());

class RequestCallBackCancelRequest {
    final int? requestCallBackId;

    RequestCallBackCancelRequest({
        this.requestCallBackId,
    });

    factory RequestCallBackCancelRequest.fromJson(Map<String, dynamic> json) => RequestCallBackCancelRequest(
        requestCallBackId: json["requestCallBackId"],
    );

    Map<String, dynamic> toJson() => {
        "requestCallBackId": requestCallBackId,
    };
}
