// // To parse this JSON data, do
// //
// //     final leasingCalculatorRequest = leasingCalculatorRequestFromJson(jsonString);
//
// import 'dart:convert';
//
// LeasingCalculatorRequest leasingCalculatorRequestFromJson(String str) => LeasingCalculatorRequest.fromJson(json.decode(str));
//
// String leasingCalculatorRequestToJson(LeasingCalculatorRequest data) => json.encode(data.toJson());
//
// class LeasingCalculatorRequest {
//   String? messageType;
//   String? vehicleCategory;
//   String? vehicleType;
//   String? manufactYear;
//   String? price;
//   String? advancedPayment;
//   String? ghostId;
//   String? amount;
//   String? tenure;
//   String? rate;
//
//   LeasingCalculatorRequest({
//     required this.messageType,
//     required this.vehicleCategory,
//     required this.vehicleType,
//     required this.manufactYear,
//     required this.price,
//     required this.advancedPayment,
//     required this.ghostId,
//     required this.amount,
//     required this.tenure,
//     required this.rate,
//   });
//
//   factory LeasingCalculatorRequest.fromJson(Map<String, dynamic> json) => LeasingCalculatorRequest(
//     messageType: json["messageType"],
//     vehicleCategory: json["vehicleCategory"],
//     vehicleType: json["vehicleType"],
//     manufactYear: json["manufactYear"],
//     price: json["price"],
//     advancedPayment: json["advancedPayment"],
//     ghostId: json["ghostId"],
//     amount: json["amount"],
//     tenure: json["tenure"],
//     rate: json["rate"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "messageType": messageType,
//     "vehicleCategory": vehicleCategory,
//     "vehicleType": vehicleType,
//     "manufactYear": manufactYear,
//     "price": price,
//     "advancedPayment": advancedPayment,
//     "ghostId": ghostId,
//     "amount": amount,
//     "tenure": tenure,
//     "rate": rate,
//   };
// }

// To parse this JSON data, do
//
//     final leasingCalculatorRequest = leasingCalculatorRequestFromJson(jsonString);

// To parse this JSON data, do
//
//     final leasingCalculatorRequest = leasingCalculatorRequestFromJson(jsonString);

import 'dart:convert';

LeasingCalculatorRequest leasingCalculatorRequestFromJson(String str) => LeasingCalculatorRequest.fromJson(json.decode(str));

String leasingCalculatorRequestToJson(LeasingCalculatorRequest data) => json.encode(data.toJson());

class LeasingCalculatorRequest {
  String? messageType;
  String? vehicleCategory;
  String? vehicleType;
  String? manufactYear;
  String? price;
  String? advancedPayment;
  String? amount;
  String? tenure;
  String? rate;

  LeasingCalculatorRequest({
    required this.messageType,
    required this.vehicleCategory,
    required this.vehicleType,
    required this.manufactYear,
    required this.price,
    required this.advancedPayment,
    required this.amount,
    required this.tenure,
    required this.rate,
  });

  factory LeasingCalculatorRequest.fromJson(Map<String, dynamic> json) => LeasingCalculatorRequest(
    messageType: json["messageType"],
    vehicleCategory: json["vehicleCategory"],
    vehicleType: json["vehicleType"],
    manufactYear: json["manufactYear"],
    price: json["price"],
    advancedPayment: json["advancedPayment"],
    amount: json["amount"],
    tenure: json["tenure"],
    rate: json["rate"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "vehicleCategory": vehicleCategory,
    "vehicleType": vehicleType,
    "manufactYear": manufactYear,
    "price": price,
    "advancedPayment": advancedPayment,
    "amount": amount,
    "tenure": tenure,
    "rate": rate,
  };
}


