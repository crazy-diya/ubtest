// To parse this JSON data, do
//
//     final calculatorPdfResponse = calculatorPdfResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

CalculatorPdfResponse calculatorPdfResponseFromJson(String str) => CalculatorPdfResponse.fromJson(json.decode(str));

String calculatorPdfResponseToJson(CalculatorPdfResponse data) => json.encode(data.toJson());

class CalculatorPdfResponse extends Serializable{
  String? document;

  CalculatorPdfResponse({
    this.document,
  });

  factory CalculatorPdfResponse.fromJson(Map<String, dynamic> json) =>
      CalculatorPdfResponse(
        document: json["document"],
      );

  Map<String, dynamic> toJson() => {
        "document": document,
  };
}
