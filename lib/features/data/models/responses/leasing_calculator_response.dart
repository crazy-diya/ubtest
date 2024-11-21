// To parse this JSON data, do
//
//     final leasingCalculatorResponse = leasingCalculatorResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

LeasingCalculatorResponse leasingCalculatorResponseFromJson(String str) => LeasingCalculatorResponse.fromJson(json.decode(str));

String leasingCalculatorResponseToJson(LeasingCalculatorResponse data) => json.encode(data.toJson());

class LeasingCalculatorResponse extends Serializable{
  String? monthlyInstallment;
  String? rate;

  LeasingCalculatorResponse({
    required this.monthlyInstallment,
    required this.rate,
  });

  factory LeasingCalculatorResponse.fromJson(Map<String, dynamic> json) => LeasingCalculatorResponse(
    monthlyInstallment: json["monthlyInstallment"],
    rate: json["rate"],
  );

  Map<String, dynamic> toJson() => {
    "monthlyInstallment": monthlyInstallment,
    "rate": rate,
  };
}
