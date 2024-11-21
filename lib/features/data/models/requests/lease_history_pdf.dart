// To parse this JSON data, do
//
//     final leaseHistoryPdfRequest = leaseHistoryPdfRequestFromJson(jsonString);

import 'dart:convert';

LeaseHistoryPdfRequest leaseHistoryPdfRequestFromJson(String str) => LeaseHistoryPdfRequest.fromJson(json.decode(str));

String leaseHistoryPdfRequestToJson(LeaseHistoryPdfRequest data) => json.encode(data.toJson());

class LeaseHistoryPdfRequest {
  String messageType;
  String leaseNo;

  LeaseHistoryPdfRequest({
    required this.messageType,
    required this.leaseNo,
  });

  factory LeaseHistoryPdfRequest.fromJson(Map<String, dynamic> json) => LeaseHistoryPdfRequest(
    messageType: json["messageType"],
    leaseNo: json["leaseNo"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "leaseNo": leaseNo,
  };
}
