// To parse this JSON data, do
//
//     final getAllFundTransferScheduleRequest = getAllFundTransferScheduleRequestFromJson(jsonString);

import 'dart:convert';

GetAllFundTransferScheduleRequest getAllFundTransferScheduleRequestFromJson(String str) => GetAllFundTransferScheduleRequest.fromJson(json.decode(str));

String getAllFundTransferScheduleRequestToJson(GetAllFundTransferScheduleRequest data) => json.encode(data.toJson());

class GetAllFundTransferScheduleRequest {
  String? messageType;
  String? txnType;

  GetAllFundTransferScheduleRequest({
    required this.messageType,
    required this.txnType,
  });

  factory GetAllFundTransferScheduleRequest.fromJson(Map<String, dynamic> json) => GetAllFundTransferScheduleRequest(
    messageType: json["messageType"],
    txnType: json["txnType"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "txnType": txnType,
  };
}

