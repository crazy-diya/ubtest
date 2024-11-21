// // To parse this JSON data, do
// //
// //     final housingLoanResponseModel = housingLoanResponseModelFromJson(jsonString);
//
// import 'dart:convert';
//
// import '../common/base_response.dart';
//
// HousingLoanResponseModel housingLoanResponseModelFromJson(String str) => HousingLoanResponseModel.fromJson(json.decode(str));
//
// String housingLoanResponseModelToJson(HousingLoanResponseModel data) => json.encode(data.toJson());
//
// class HousingLoanResponseModel extends Serializable{
//   String? responseCode;
//   String? responseDescription;
//   HousingLoanResponseData? data;
//
//   HousingLoanResponseModel({
//     required this.responseCode,
//     required this.responseDescription,
//     required this.data,
//   });
//
//   factory HousingLoanResponseModel.fromJson(Map<String, dynamic> json) => HousingLoanResponseModel(
//     responseCode: json["responseCode"],
//     responseDescription: json["responseDescription"],
//     data: json["data"]!=null?HousingLoanResponseData.fromJson(json["data"]):HousingLoanResponseData(),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "responseCode": responseCode,
//     "responseDescription": responseDescription,
//     "data": data?.toJson(),
//   };
// }
//
// class HousingLoanResponseData {
//   String? monthlyInstallment;
//   String? amount;
//   String? tenure;
//   String? rate;
//
//   HousingLoanResponseData({
//      this.monthlyInstallment,
//      this.amount,
//      this.tenure,
//      this.rate,
//   });
//
//   factory HousingLoanResponseData.fromJson(Map<String, dynamic> json) => HousingLoanResponseData(
//     monthlyInstallment: json["monthlyInstallment"],
//     amount: json["amount"],
//     tenure: json["tenure"],
//     rate: json["rate"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "monthlyInstallment": monthlyInstallment,
//     "amount": amount,
//     "tenure": tenure,
//     "rate": rate,
//   };
// }

// To parse this JSON data, do
//
//     final housingLoanResponse = housingLoanResponseFromJson(jsonString);
// To parse this JSON data, do
//
//     final housingLoanResponseModel = housingLoanResponseModelFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

HousingLoanResponseModel housingLoanResponseModelFromJson(String str) => HousingLoanResponseModel.fromJson(json.decode(str));

String housingLoanResponseModelToJson(HousingLoanResponseModel data) => json.encode(data.toJson());

class HousingLoanResponseModel extends Serializable{
  String? monthlyInstallment;
  String? amount;
  String? tenure;
  String? rate;

  HousingLoanResponseModel({
    required this.monthlyInstallment,
    required this.amount,
    required this.tenure,
    required this.rate,
  });

  factory HousingLoanResponseModel.fromJson(Map<String, dynamic> json) => HousingLoanResponseModel(
    monthlyInstallment: json["monthlyInstallment"],
    amount: json["amount"],
    tenure: json["tenure"],
    rate: json["rate"],
  );

  Map<String, dynamic> toJson() => {
    "monthlyInstallment": monthlyInstallment,
    "amount": amount,
    "tenure": tenure,
    "rate": rate,
  };
}


