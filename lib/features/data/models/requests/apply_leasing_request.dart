// To parse this JSON data, do
//
//     final applyLeasingCalculatorRequest = applyLeasingCalculatorRequestFromJson(jsonString);

import 'dart:convert';

ApplyLeasingCalculatorRequest applyLeasingCalculatorRequestFromJson(String str) => ApplyLeasingCalculatorRequest.fromJson(json.decode(str));

String applyLeasingCalculatorRequestToJson(ApplyLeasingCalculatorRequest data) => json.encode(data.toJson());

class ApplyLeasingCalculatorRequest {
  final String? messageType;
  final String? name;
  final String? nic;
  final String? email;
  final String? mobileNumber;
  final String? branch;
  final String? reqType;
  final String? rate;
  // final String? installmentType;
  final String? vehicleCategory;
  final String? vehicleType;
  final String? interestPeriod;
  final int? manufactYear;
  final int? price;
  final int? advancedPayment;
  final int? amount;

  ApplyLeasingCalculatorRequest({
    this.messageType,
    this.name,
    this.nic,
    this.email,
    this.mobileNumber,
    this.branch,
    this.reqType,
    this.rate,
    // this.installmentType,
    this.vehicleCategory,
    this.vehicleType,
    this.manufactYear,
    this.interestPeriod,
    this.price,
    this.advancedPayment,
    this.amount,
  });

  factory ApplyLeasingCalculatorRequest.fromJson(Map<String, dynamic> json) => ApplyLeasingCalculatorRequest(
    messageType: json["messageType"],
    name: json["name"],
    nic: json["nic"],
    email: json["email"],
    mobileNumber: json["mobileNumber"],
    branch: json["branch"],
    reqType: json["reqType"],
    rate: json["rate"],
    // installmentType: json["installmentType"],
    vehicleCategory: json["vehicleCategory"],
    vehicleType: json["vehicleType"],
    manufactYear: json["manufactYear"],
    price: json["price"],
    advancedPayment: json["advancedPayment"],
    amount: json["amount"],
    interestPeriod: json["interestPeriod"],
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
    // "installmentType": installmentType,
    "vehicleCategory": vehicleCategory,
    "vehicleType": vehicleType,
    "manufactYear": manufactYear,
    "price": price,
    "advancedPayment": advancedPayment,
    "amount": amount,
    "interestPeriod": interestPeriod,
  };
}
