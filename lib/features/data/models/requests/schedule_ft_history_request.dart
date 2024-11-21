// To parse this JSON data, do
//
//     final scheduleFtHistoryReq = scheduleFtHistoryReqFromJson(jsonString);

import 'dart:convert';

ScheduleFtHistoryReq scheduleFtHistoryReqFromJson(String str) => ScheduleFtHistoryReq.fromJson(json.decode(str));

String scheduleFtHistoryReqToJson(ScheduleFtHistoryReq data) => json.encode(data.toJson());

class ScheduleFtHistoryReq {
  String? messageType;
  int? scheduleId;
  String? txnType;
  int? page;
  int? size;

  ScheduleFtHistoryReq({
     this.messageType,
     this.scheduleId,
     this.txnType,
     this.page,
     this.size,
  });

  factory ScheduleFtHistoryReq.fromJson(Map<String, dynamic> json) => ScheduleFtHistoryReq(
    messageType: json["messageType"],
    scheduleId: json["scheduleId"],
    txnType: json["txnType"],
    page: json["page"],
    size: json["size"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "scheduleId": scheduleId,
    "txnType": txnType,
    "page": page,
    "size": size,
  };
}
