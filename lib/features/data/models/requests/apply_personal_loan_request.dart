// To parse this JSON data, do
//
//     final applyPersonalLoanRequest = applyPersonalLoanRequestFromJson(jsonString);

import 'dart:convert';

ApplyPersonalLoanRequest applyPersonalLoanRequestFromJson(String str) => ApplyPersonalLoanRequest.fromJson(json.decode(str));

String applyPersonalLoanRequestToJson(ApplyPersonalLoanRequest data) => json.encode(data.toJson());

class ApplyPersonalLoanRequest {
  final String? messageType;
  final String? name;
  final String? nic;
  final String? email;
  final String? mobileNumber;
  final String? amount;
  final String? paymentPeriod;
  final String? grossIncome;
  final String? reqType;
  final String? rate;
  final String? installmentType;

  ApplyPersonalLoanRequest({
    this.messageType,
    this.name,
    this.nic,
    this.email,
    this.mobileNumber,
    this.amount,
    this.paymentPeriod,
    this.grossIncome,
    this.reqType,
    this.rate,
    this.installmentType,
  });

  factory ApplyPersonalLoanRequest.fromJson(Map<String, dynamic> json) => ApplyPersonalLoanRequest(
    messageType: json["messageType"],
    name: json["name"],
    nic: json["nic"],
    email: json["email"],
    mobileNumber: json["mobileNumber"],
    amount: json["amount"],
    paymentPeriod: json["paymentPeriod"],
    grossIncome: json["grossIncome"],
    reqType: json["reqType"],
    rate: json["rate"],
    installmentType: json["installmentType"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "name": name,
    "nic": nic,
    "email": email,
    "mobileNumber": mobileNumber,
    "amount": amount,
    "paymentPeriod": paymentPeriod,
    "grossIncome": grossIncome,
    "reqType": reqType,
    "rate": rate,
    "installmentType": installmentType,
  };
}
