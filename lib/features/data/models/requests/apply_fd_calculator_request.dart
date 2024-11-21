// // To parse this JSON data, do
// //
// //     final applyFdCalculatorRequest = applyFdCalculatorRequestFromJson(jsonString);
//
// import 'dart:convert';
//
// ApplyFdCalculatorRequest applyFdCalculatorRequestFromJson(String str) => ApplyFdCalculatorRequest.fromJson(json.decode(str));
//
// String applyFdCalculatorRequestToJson(ApplyFdCalculatorRequest data) => json.encode(data.toJson());
//
// class ApplyFdCalculatorRequest {
//   final String? messageType;
//   final String? name;
//   final String? nic;
//   final String? email;
//   final String? mobileNumber;
//   final String? branch;
//   final String? reqType;
//   final String? rate;
//   // final String? installmentType;
//   final String? interestPeriod;
//   final String? currencyCode;
//   final String? interestRecieved;
//
//   ApplyFdCalculatorRequest({
//     this.messageType,
//     this.name,
//     this.nic,
//     this.email,
//     this.mobileNumber,
//     this.branch,
//     this.reqType,
//     this.rate,
//     // this.installmentType,
//     this.interestPeriod,
//     this.currencyCode,
//     this.interestRecieved,
//   });
//
//   factory ApplyFdCalculatorRequest.fromJson(Map<String, dynamic> json) => ApplyFdCalculatorRequest(
//     messageType: json["messageType"],
//     name: json["name"],
//     nic: json["nic"],
//     email: json["email"],
//     mobileNumber: json["mobileNumber"],
//     branch: json["branch"],
//     reqType: json["reqType"],
//     rate: json["rate"],
//     // installmentType: json["installmentType"],
//     interestPeriod: json["interestPeriod"],
//     currencyCode: json["currencyCode"],
//     interestRecieved: json["interestRecieved"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "messageType": messageType,
//     "name": name,
//     "nic": nic,
//     "email": email,
//     "mobileNumber": mobileNumber,
//     "branch": branch,
//     "reqType": reqType,
//     "rate": rate,
//     // "installmentType": installmentType,
//     "interestPeriod": interestPeriod,
//     "currencyCode": currencyCode,
//     "interestRecieved": interestRecieved,
//   };
// }
// To parse this JSON data, do
//
//     final applyFdCalculatorRequest = applyFdCalculatorRequestFromJson(jsonString);

import 'dart:convert';

ApplyFdCalculatorRequest applyFdCalculatorRequestFromJson(String str) => ApplyFdCalculatorRequest.fromJson(json.decode(str));

String applyFdCalculatorRequestToJson(ApplyFdCalculatorRequest data) => json.encode(data.toJson());

class ApplyFdCalculatorRequest {
  final String? messageType;
  final String? name;
  final String? nic;
  final String? email;
  final String? mobileNumber;
  final String? branch;
  final String? reqType;
  final String? rate;
  final String? installmentType;
  final String? interestPeriod;
  final String? currencyCode;
  final String? interestRecieved;
  final String? amount;

  ApplyFdCalculatorRequest({
    this.messageType,
    this.name,
    this.nic,
    this.email,
    this.mobileNumber,
    this.branch,
    this.reqType,
    this.rate,
    this.installmentType,
    this.interestPeriod,
    this.currencyCode,
    this.interestRecieved,
    this.amount,
  });

  factory ApplyFdCalculatorRequest.fromJson(Map<String, dynamic> json) => ApplyFdCalculatorRequest(
    messageType: json["messageType"],
    name: json["name"],
    nic: json["nic"],
    email: json["email"],
    mobileNumber: json["mobileNumber"],
    branch: json["branch"],
    reqType: json["reqType"],
    rate: json["rate"],
    installmentType: json["installmentType"],
    interestPeriod: json["interestPeriod"],
    currencyCode: json["currencyCode"],
    interestRecieved: json["interestRecieved"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "name": name,
    "nic": nic,
    "email": email,
    "mobileNumber": mobileNumber,
    "branch": branch,
    "reqType": reqType,
    "rate": rate,
    "installmentType": installmentType,
    "interestPeriod": interestPeriod,
    "currencyCode": currencyCode,
    "interestRecieved": interestRecieved,
    "amount": amount,
  };
}
