// To parse this JSON data, do
//
//     final leaseHistoryrequest = leaseHistoryrequestFromJson(jsonString);

import 'dart:convert';

LeaseHistoryrequest leaseHistoryrequestFromJson(String str) => LeaseHistoryrequest.fromJson(json.decode(str));

String leaseHistoryrequestToJson(LeaseHistoryrequest data) => json.encode(data.toJson());

class LeaseHistoryrequest {
  String messageType;
  int page;
  int size;
  String accountNo;

  LeaseHistoryrequest({
    required this.messageType,
    required this.page,
    required this.size,
    required this.accountNo,
  });

  factory LeaseHistoryrequest.fromJson(Map<String, dynamic> json) => LeaseHistoryrequest(
    messageType: json["messageType"],
    page: json["page"],
    size: json["size"],
    accountNo: json["accountNo"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "page": page,
    "size": size,
    "accountNo": accountNo,
  };
}
