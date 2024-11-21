// To parse this JSON data, do
//
//     final housingLoanRequestModel = housingLoanRequestModelFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

HousingLoanRequestModel housingLoanRequestModelFromJson(String str) => HousingLoanRequestModel.fromJson(json.decode(str));

String housingLoanRequestModelToJson(HousingLoanRequestModel data) => json.encode(data.toJson());

class HousingLoanRequestModel extends Serializable {
  String? messageType;
  String? amount;
  String? tenure;
  String? rate;
  String? installmentType;

  HousingLoanRequestModel({
    required this.messageType,
    required this.amount,
    required this.tenure,
    required this.rate,
    required this.installmentType,
  });

  factory HousingLoanRequestModel.fromJson(Map<String, dynamic> json) => HousingLoanRequestModel(
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
