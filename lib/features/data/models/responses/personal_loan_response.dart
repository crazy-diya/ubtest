// To parse this JSON data, do
//
//     final personalLoanResponse = personalLoanResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

PersonalLoanResponse personalLoanResponseFromJson(String str) => PersonalLoanResponse.fromJson(json.decode(str));

String personalLoanResponseToJson(PersonalLoanResponse data) => json.encode(data.toJson());

class PersonalLoanResponse extends Serializable {
  String? monthlyInstallment;
  String? amount;
  String? tenure;
  String? rate;
  String? installmentType;

  PersonalLoanResponse({
    this.monthlyInstallment,
    this.amount,
    this.tenure,
    this.rate,
    this.installmentType,
  });

  factory PersonalLoanResponse.fromJson(Map<String, dynamic> json) => PersonalLoanResponse(
    monthlyInstallment: json["monthlyInstallment"],
    amount: json["amount"],
    tenure: json["tenure"],
    rate: json["rate"],
    installmentType: json["installmentType"],
  );

  Map<String, dynamic> toJson() => {
    "monthlyInstallment": monthlyInstallment,
    "amount": amount,
    "tenure": tenure,
    "rate": rate,
    "installmentType": installmentType,
  };
}
