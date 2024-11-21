// To parse this JSON data, do
//
//     final transactionNotificationRequest = transactionNotificationRequestFromJson(jsonString);

// import 'dart:convert';
//
// TransactionNotificationRequest transactionNotificationRequestFromJson(
//         String str) =>
//     TransactionNotificationRequest.fromJson(json.decode(str));
//
// String transactionNotificationRequestToJson(
//         TransactionNotificationRequest data) =>
//     json.encode(data.toJson());
//
// class TransactionNotificationRequest {
//   final int? page;
//   final int? size;
//
//   TransactionNotificationRequest({
//     this.page,
//     this.size,
//   });
//
//   factory TransactionNotificationRequest.fromJson(Map<String, dynamic> json) =>
//       TransactionNotificationRequest(
//         page: json["page"],
//         size: json["size"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "page": page,
//         "size": size,
//       };
// }

// To parse this JSON data, do
//
//     final transactionNotificationRequest = transactionNotificationRequestFromJson(jsonString);

import 'dart:convert';

TransactionNotificationRequest transactionNotificationRequestFromJson(String str) => TransactionNotificationRequest.fromJson(json.decode(str));

String transactionNotificationRequestToJson(TransactionNotificationRequest data) => json.encode(data.toJson());

class TransactionNotificationRequest {
  String? epicUserId;
  int? page;
  int? size;
  String? readStatus;

  TransactionNotificationRequest({
    this.epicUserId,
    this.page,
    this.size,
    this.readStatus,
  });

  factory TransactionNotificationRequest.fromJson(Map<String, dynamic> json) => TransactionNotificationRequest(
    epicUserId: json["epicUserId"],
    page: json["page"],
    size: json["size"],
    readStatus: json["readStatus"],
  );

  Map<String, dynamic> toJson() => {
    "epicUserId": epicUserId,
    "page": page,
    "size": size,
    "readStatus": readStatus,
  };
}
