// To parse this JSON data, do
//
//     final personalLoanRequest = personalLoanRequestFromJson(jsonString);

import 'dart:convert';

PersonalLoanRequest personalLoanRequestFromJson(String str) => PersonalLoanRequest.fromJson(json.decode(str));

String personalLoanRequestToJson(PersonalLoanRequest data) => json.encode(data.toJson());

class PersonalLoanRequest {
  String? messageType;
  String? amount;
  String? tenure;
  String? rate;
  String? installmentType;

  PersonalLoanRequest({
    this.messageType,
    this.amount,
    this.tenure,
    this.rate,
    this.installmentType,
  });

  factory PersonalLoanRequest.fromJson(Map<String, dynamic> json) => PersonalLoanRequest(
    messageType: json["messageType"],
    amount: json["amount"],
    tenure: json["tenure"],
    rate: json["rate"],
    installmentType: json["installmentType"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "amount": amount,
    "tenure": tenure,
    "rate": rate,
    "installmentType": installmentType,
  };
}
