// To parse this JSON data, do
//
//     final portfolioLeaseDetailsResponse = portfolioLeaseDetailsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';


PortfolioLeaseDetailsResponse portfolioLeaseDetailsResponseFromJson(String str) => PortfolioLeaseDetailsResponse.fromJson(json.decode(str));

String portfolioLeaseDetailsResponseToJson(PortfolioLeaseDetailsResponse data) => json.encode(data.toJson());

class PortfolioLeaseDetailsResponse extends Serializable{
    final int? totalOutStandingBalance;
    final List<LeaseDetailsResponseDtoList>? leaseDetailsResponseDtoList;

    PortfolioLeaseDetailsResponse({
        this.totalOutStandingBalance,
        this.leaseDetailsResponseDtoList,
    });

    factory PortfolioLeaseDetailsResponse.fromJson(Map<String, dynamic> json) => PortfolioLeaseDetailsResponse(
        totalOutStandingBalance: json["totalOutStandingBalance"],
        leaseDetailsResponseDtoList: json["leaseDetailsResponseDTOList"] == null ? [] : List<LeaseDetailsResponseDtoList>.from(json["leaseDetailsResponseDTOList"].map((x) => LeaseDetailsResponseDtoList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "totalOutStandingBalance": totalOutStandingBalance,
        "leaseDetailsResponseDTOList": leaseDetailsResponseDtoList == null ? [] : List<LeaseDetailsResponseDtoList>.from(leaseDetailsResponseDtoList!.map((x) => x)),
    };
}

class LeaseDetailsResponseDtoList {
  String? leaseAmount;
  String? productDescription;
  String? leaseNumber;
  String? capitalOutstanding;
  String? rentalAmount;
  String? nextPaymentDate;
  String? totalArrears;
  String? maturityDate;
  String? tenure;
  String? cfcurr;

  LeaseDetailsResponseDtoList({
    required this.leaseAmount,
    required this.productDescription,
    required this.leaseNumber,
    required this.capitalOutstanding,
    required this.rentalAmount,
    required this.nextPaymentDate,
    required this.totalArrears,
    required this.maturityDate,
    required this.tenure,
    required this.cfcurr,
  });

  factory LeaseDetailsResponseDtoList.fromJson(Map<String, dynamic> json) =>
      LeaseDetailsResponseDtoList(
        leaseAmount: json["leaseAmount"].toString(),
        productDescription: json["productDescription"],
        leaseNumber: json["leaseNumber"],
        capitalOutstanding: json["capitalOutstanding"],
        rentalAmount: json["rentalAmount"],
        nextPaymentDate: json["nextPaymentDate"],
        totalArrears: json["totalArrears"],
        maturityDate: json["maturityDate"],
        tenure: json["tenure"],
        cfcurr: json["cfcurr"].toString().trim(),
      );

  Map<String, dynamic> toJson() => {
        "leaseAmount": leaseAmount,
        "productDescription": productDescription,
        "leaseNumber": leaseNumber,
        "capitalOutstanding": capitalOutstanding,
        "rentalAmount": rentalAmount,
        "nextPaymentDate": nextPaymentDate,
        "totalArrears": totalArrears,
        "maturityDate": maturityDate,
        "tenure": tenure,
        "cfcurr": cfcurr,
      };
}
