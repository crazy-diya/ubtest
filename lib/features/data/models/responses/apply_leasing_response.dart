// To parse this JSON data, do
//
//     final applyLeasingCalculatorResponse = applyLeasingCalculatorResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

ApplyLeasingCalculatorResponse applyLeasingCalculatorResponseFromJson(String str) => ApplyLeasingCalculatorResponse.fromJson(json.decode(str));

String applyLeasingCalculatorResponseToJson(ApplyLeasingCalculatorResponse data) => json.encode(data.toJson());

class ApplyLeasingCalculatorResponse extends Serializable{
  String? responseCode;
  String? responseDescription;

  ApplyLeasingCalculatorResponse({
    this.responseCode,
    this.responseDescription,
  });

  factory ApplyLeasingCalculatorResponse.fromJson(Map<String, dynamic> json) => ApplyLeasingCalculatorResponse(
    responseCode: json["responseCode"],
    responseDescription: json["responseDescription"],
  );

  Map<String, dynamic> toJson() => {
    "responseCode": responseCode,
    "responseDescription": responseDescription,
  };
}
