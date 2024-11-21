// // To parse this JSON data, do
// //
// //     final pastCardStatementsrequest = pastCardStatementsrequestFromJson(jsonString);
//
// import 'dart:convert';
//
// PastCardStatementsrequest pastCardStatementsrequestFromJson(String str) => PastCardStatementsrequest.fromJson(json.decode(str));
//
// String pastCardStatementsrequestToJson(PastCardStatementsrequest data) => json.encode(data.toJson());
//
// class PastCardStatementsrequest {
//   String messageType;
//   String accountNo;
//   int year;
//   int month;
//   int page;
//   int size;
//
//   PastCardStatementsrequest({
//     required this.messageType,
//     required this.accountNo,
//     required this.year,
//     required this.month,
//     required this.page,
//     required this.size,
//   });
//
//   factory PastCardStatementsrequest.fromJson(Map<String, dynamic> json) => PastCardStatementsrequest(
//     messageType: json["messageType"],
//     accountNo: json["accountNo"],
//     year: json["year"],
//     month: json["month"],
//     page: json["page"],
//     size: json["size"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "messageType": messageType,
//     "accountNo": accountNo,
//     "year": year,
//     "month": month,
//     "page": page,
//     "size": size,
//   };
// }


// To parse this JSON data, do
//
//     final pastCardStatementsrequest = pastCardStatementsrequestFromJson(jsonString);

import 'dart:convert';

PastCardStatementsrequest pastCardStatementsrequestFromJson(String str) => PastCardStatementsrequest.fromJson(json.decode(str));

String pastCardStatementsrequestToJson(PastCardStatementsrequest data) => json.encode(data.toJson());

class PastCardStatementsrequest {
  final String? messageType;
  final String? maskedPrimaryCardNumber;
  final String? billMonth;

  PastCardStatementsrequest({
    this.messageType,
    this.maskedPrimaryCardNumber,
    this.billMonth,
  });

  factory PastCardStatementsrequest.fromJson(Map<String, dynamic> json) => PastCardStatementsrequest(
    messageType: json["messageType"],
    maskedPrimaryCardNumber: json["maskedPrimaryCardNumber"],
    billMonth: json["billMonth"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "maskedPrimaryCardNumber": maskedPrimaryCardNumber,
    "billMonth": billMonth,
  };
}
