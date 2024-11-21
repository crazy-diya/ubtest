// To parse this JSON data, do
//
//     final requestCallBackGetRequest = requestCallBackGetRequestFromJson(jsonString);

import 'dart:convert';

RequestCallBackGetDefaultDataRequest requestCallBackGetDefaultDataRequest(String str) => RequestCallBackGetDefaultDataRequest.fromJson(json.decode(str));

String requestCallBackGetDefaultDataRequestToJson(RequestCallBackGetDefaultDataRequest data) => json.encode(data.toJson());

class RequestCallBackGetDefaultDataRequest {

    RequestCallBackGetDefaultDataRequest();

    factory RequestCallBackGetDefaultDataRequest.fromJson(Map<String, dynamic> json) => RequestCallBackGetDefaultDataRequest(
    );

    Map<String, dynamic> toJson() => {};
}
