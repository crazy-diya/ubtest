// To parse this JSON data, do
//
//     final leaseHistoryExcelRequest = leaseHistoryExcelRequestFromJson(jsonString);

import 'dart:convert';

LeaseHistoryExcelRequest leaseHistoryExcelRequestFromJson(String str) => LeaseHistoryExcelRequest.fromJson(json.decode(str));

String leaseHistoryExcelRequestToJson(LeaseHistoryExcelRequest data) => json.encode(data.toJson());

class LeaseHistoryExcelRequest {
  String messageType;
  String leaseNo;

  LeaseHistoryExcelRequest({
    required this.messageType,
    required this.leaseNo,
  });

  factory LeaseHistoryExcelRequest.fromJson(Map<String, dynamic> json) => LeaseHistoryExcelRequest(
    messageType: json["messageType"],
    leaseNo: json["leaseNo"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "leaseNo": leaseNo,
  };
}
