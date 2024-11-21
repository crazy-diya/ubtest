// To parse this JSON data, do
//
//     final calculatorPdfRequest = calculatorPdfRequestFromJson(jsonString);

import 'dart:convert';

CalculatorPdfRequest calculatorPdfRequestFromJson(String str) => CalculatorPdfRequest.fromJson(json.decode(str));

String calculatorPdfRequestToJson(CalculatorPdfRequest data) => json.encode(data.toJson());

class CalculatorPdfRequest {
  String? title;
  List<DocBody>? docBody;

  CalculatorPdfRequest({
    this.title,
    this.docBody,
  });

  factory CalculatorPdfRequest.fromJson(Map<String, dynamic> json) => CalculatorPdfRequest(
    title: json["title"],
    docBody: List<DocBody>.from(json["docBody"].map((x) => DocBody.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "docBody": List<dynamic>.from(docBody!.map((x) => x.toJson())),
  };
}

class DocBody {
  String? fieldName;
  String? fieldValue;

  DocBody({
    this.fieldName,
    this.fieldValue,
  });

  factory DocBody.fromJson(Map<String, dynamic> json) => DocBody(
    fieldName: json["fieldName"],
    fieldValue: json["fieldValue"],
  );

  Map<String, dynamic> toJson() => {
    "fieldName": fieldName,
    "fieldValue": fieldValue,
  };
}
