// // // To parse this JSON data, do
// // //
// // //     final fdCalculatorResponse = fdCalculatorResponseFromJson(jsonString);
// //
// // import 'dart:convert';
// //
// // import 'package:supercharged/supercharged.dart';
// //
// // import '../common/base_response.dart';
// //
// // FdCalculatorResponse fdCalculatorResponseFromJson(String str) => FdCalculatorResponse.fromJson(json.decode(str));
// //
// // String fdCalculatorResponseToJson(FdCalculatorResponse data) => json.encode(data.toJson());
// //
// // class FdCalculatorResponse extends Serializable{
// //   String? currencyCode;
// //   String? currency;
// //   int? monthlyValue;
// //   String? nominalRate;
// //   String? annualRate;
// //
// //   FdCalculatorResponse({
// //     this.currencyCode,
// //     this.currency,
// //     this.monthlyValue,
// //     this.nominalRate,
// //     this.annualRate,
// //   });
// //
// //   factory FdCalculatorResponse.fromJson(Map<String, dynamic> json) => FdCalculatorResponse(
// //     currencyCode: json["currencyCode"],
// //     currency: json["currency"],
// //     monthlyValue: json["monthlyValue".toDouble],
// //     nominalRate: json["nominalRate"],
// //     annualRate: json["annualRate"],
// //   );
// //
// //   Map<String, dynamic> toJson() => {
// //     "currencyCode": currencyCode,
// //     "currency": currency,
// //     "monthlyValue": monthlyValue,
// //     "nominalRate": nominalRate,
// //     "annualRate": annualRate,
// //   };
// // }
//
//
// // To parse this JSON data, do
// //
// //     final fdCalculatorResponse = fdCalculatorResponseFromJson(jsonString);
//
// import 'dart:convert';
//
// import '../common/base_response.dart';
//
// FdCalculatorResponse fdCalculatorResponseFromJson(String str) => FdCalculatorResponse.fromJson(json.decode(str));
//
// String fdCalculatorResponseToJson(FdCalculatorResponse data) => json.encode(data.toJson());
//
// class FdCalculatorResponse extends Serializable{
//   String? currencyCode;
//   String? currency;
//   String? monthlyValue;
//   String? nominalRate;
//   String? annualRate;
//
//   FdCalculatorResponse({
//     this.currencyCode,
//     this.currency,
//     this.monthlyValue,
//     this.nominalRate,
//     this.annualRate,
//   });
//
//   factory FdCalculatorResponse.fromJson(Map<String, dynamic> json) => FdCalculatorResponse(
//     currencyCode: json["currencyCode"],
//     currency: json["currency"],
//     monthlyValue: json["monthlyValue"],
//     nominalRate: json["nominalRate"],
//     annualRate: json["annualRate"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "currencyCode": currencyCode,
//     "currency": currency,
//     "monthlyValue": monthlyValue,
//     "nominalRate": nominalRate,
//     "annualRate": annualRate,
//   };
// }
//
// To parse this JSON data, do
//
//     final fdCalculatorResponse = fdCalculatorResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

FdCalculatorResponse fdCalculatorResponseFromJson(String str) => FdCalculatorResponse.fromJson(json.decode(str));

String fdCalculatorResponseToJson(FdCalculatorResponse data) => json.encode(data.toJson());

class FdCalculatorResponse extends Serializable{
  final String? currencyCode;
  final String? currency;
  final String? monthlyValue;
  final String? nominalRate;
  final String? monthlyRate;
  final String? maturityValue;

  FdCalculatorResponse({
    this.currencyCode,
    this.currency,
    this.monthlyValue,
    this.nominalRate,
    this.monthlyRate,
    this.maturityValue,
  });

  factory FdCalculatorResponse.fromJson(Map<String, dynamic> json) => FdCalculatorResponse(
    currencyCode: json["currencyCode"],
    currency: json["currency"],
    monthlyValue: json["monthlyValue"],
    nominalRate: json["nominalRate"],
    monthlyRate: json["monthlyRate"],
    maturityValue: json["maturityValue"],
  );

  Map<String, dynamic> toJson() => {
    "currencyCode": currencyCode,
    "currency": currency,
    "monthlyValue": monthlyValue,
    "nominalRate": nominalRate,
    "monthlyRate": monthlyRate,
    "maturityValue": maturityValue,
  };
}
