// To parse this JSON data, do
//
//     final portfolioAccDetailsResponse = portfolioAccDetailsResponseFromJson(jsonString);

import 'dart:convert';


import '../common/base_response.dart';

PortfolioAccDetailsResponse portfolioAccDetailsResponseFromJson(String str) => PortfolioAccDetailsResponse.fromJson(json.decode(str));

String portfolioAccDetailsResponseToJson(PortfolioAccDetailsResponse data) => json.encode(data.toJson());

class PortfolioAccDetailsResponse extends Serializable {
  String? totalOutstanding;
  List<PortfolioAccountDetailsListResponseDto>? portfolioAccountDetailsListResponseDtos;

  PortfolioAccDetailsResponse({
    this.totalOutstanding,
    this.portfolioAccountDetailsListResponseDtos,
  });

  factory PortfolioAccDetailsResponse.fromJson(Map<String, dynamic> json) => PortfolioAccDetailsResponse(
    totalOutstanding: json["totalOutstanding"].toString(),
    portfolioAccountDetailsListResponseDtos: List<PortfolioAccountDetailsListResponseDto>.from(json["portfolioAccountDetailsListResponseDTOS"].map((x) => PortfolioAccountDetailsListResponseDto.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "totalOutstanding": totalOutstanding,
    "portfolioAccountDetailsListResponseDTOS": List<dynamic>.from(portfolioAccountDetailsListResponseDtos!.map((x) => x.toJson())),
  };
}

class PortfolioAccountDetailsListResponseDto {
  String? productName;
  String? productCode;
  double? totalOutStandingBalance;
  List<PortfolioAccountDetailsResponseDtoList>? portfolioAccountDetailsResponseDtoList;

  PortfolioAccountDetailsListResponseDto({
    this.productName,
    this.productCode,
    this.totalOutStandingBalance,
    this.portfolioAccountDetailsResponseDtoList,
  });

  factory PortfolioAccountDetailsListResponseDto.fromJson(Map<String, dynamic> json) => PortfolioAccountDetailsListResponseDto(
    productName: json["productName"],
    productCode: json["productCode"],
    totalOutStandingBalance: json["totalOutStandingBalance"].toDouble(),
    portfolioAccountDetailsResponseDtoList: List<PortfolioAccountDetailsResponseDtoList>.from(json["portfolioAccountDetailsResponseDTOList"].map((x) => PortfolioAccountDetailsResponseDtoList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "productName": productName,
    "productCode": productCode,
    "totalOutStandingBalance": totalOutStandingBalance,
    "portfolioAccountDetailsResponseDTOList": List<dynamic>.from(portfolioAccountDetailsResponseDtoList!.map((x) => x.toJson())),
  };
}

class PortfolioAccountDetailsResponseDtoList {
  String? nickName;
  String? accountNumber;
  String? productName;
  String? currentBalance;
  String? holdBalance;
  String? availableBalance;
  String? branchName;
  String? status;
  String? isSavings;

  PortfolioAccountDetailsResponseDtoList({
    this.accountNumber,
    this.productName,
    this.currentBalance,
    this.holdBalance,
    this.availableBalance,
    this.branchName,
    this.status,
    this.isSavings,
    this.nickName,
  });

  factory PortfolioAccountDetailsResponseDtoList.fromJson(Map<String, dynamic> json) => PortfolioAccountDetailsResponseDtoList(
    accountNumber: json["accountNumber"],
    productName: json["productName"],
    currentBalance: json["currentBalance"],
    holdBalance: json["holdBalance"],
    availableBalance: json["availableBalance"],
    branchName: json["branchName"],
    status: json["status"],
    isSavings: json["isSavings"],
    nickName: json["nickName"],
  );

  Map<String, dynamic> toJson() => {
    "accountNumber": accountNumber,
    "productName": productName,
    "currentBalance": currentBalance,
    "holdBalance": holdBalance,
    "availableBalance": availableBalance,
    "branchName": branchName,
    "status": status,
    "isSavings": isSavings,
    "nickName": nickName,
  };
}
