// To parse this JSON data, do
//
//     final leaseReqFieldDataRequest = leaseReqFieldDataRequestFromJson(jsonString);

import 'dart:convert';

LeaseReqFieldDataRequest leaseReqFieldDataRequestFromJson(String str) => LeaseReqFieldDataRequest.fromJson(json.decode(str));

String leaseReqFieldDataRequestToJson(LeaseReqFieldDataRequest data) => json.encode(data.toJson());

class LeaseReqFieldDataRequest {
  LeaseReqFieldDataRequest({
    this.messageType,
  });

  String? messageType;

  factory LeaseReqFieldDataRequest.fromJson(Map<String, dynamic> json) => LeaseReqFieldDataRequest(
    messageType: json["messageType"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
  };
}
