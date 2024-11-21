// To parse this JSON data, do
//
//     final portfolioUserFdDetailsResponse = portfolioUserFdDetailsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';

// To parse this JSON data, do
//
//     final portfolioLeaseDetailsResponse = portfolioLeaseDetailsResponseFromJson(jsonString);



PortfolioUserFdDetailsResponse portfolioUserFdDetailsResponseFromJson(String str) => PortfolioUserFdDetailsResponse.fromJson(json.decode(str));

String portfolioUserFdDetailsResponseToJson(PortfolioUserFdDetailsResponse data) => json.encode(data.toJson());

class PortfolioUserFdDetailsResponse extends Serializable{
    final List<FdDetailsResponseDtoList>? fdDetailsResponseDtoList;

    PortfolioUserFdDetailsResponse({
        this.fdDetailsResponseDtoList,
    });

    factory PortfolioUserFdDetailsResponse.fromJson(Map<String, dynamic> json) => PortfolioUserFdDetailsResponse(
        fdDetailsResponseDtoList: json["accountDetailsResponseDTOS"] == null ? [] : List<FdDetailsResponseDtoList>.from(json["accountDetailsResponseDTOS"]!.map((x) => FdDetailsResponseDtoList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "accountDetailsResponseDTOS": fdDetailsResponseDtoList == null ? [] : List<dynamic>.from(fdDetailsResponseDtoList!.map((x) => x.toJson())),
    };
}



class FdDetailsResponseDtoList {
  int instrumentId;
  String fdtype;
  String balance;
  String accountNumber;
  String rate;
  String tenure;
  String cfcurr;
  String convertedActualBalance;
  DateTime openningDate;
  DateTime lastRenewalDate;
  DateTime maturityDate;

  FdDetailsResponseDtoList({
    required this.fdtype,
    required this.balance,
    required this.accountNumber,
    required this.rate,
    required this.tenure,
    required this.cfcurr,
    required this.convertedActualBalance,
    required this.openningDate,
    required this.lastRenewalDate,
    required this.maturityDate,
    required this.instrumentId,
  });

  factory FdDetailsResponseDtoList.fromJson(Map<String, dynamic> json) => FdDetailsResponseDtoList(
        fdtype: json["fdtype"],
        instrumentId: json["instrumentId"],
        balance: json["balance"],
        accountNumber: json["accountNumber"],
        rate: json["rate"],
        tenure: json["tenure"],
    cfcurr: json["cfcurr"].toString().trim(),
    convertedActualBalance: json["convertedActualBalance"],
        openningDate: DateTime.parse(json["openningDate"].toString().isDate() == true
            ? json["openningDate"]
            : json["openningDate"].toString().toValidDate()),
        lastRenewalDate: DateTime.parse(json["lastRenewalDate"].toString().isDate() == true
            ? json["lastRenewalDate"]
            : json["lastRenewalDate"].toString().toValidDate()),
        maturityDate: DateTime.parse(json["maturityDate"].toString().isDate() == true
            ? json["maturityDate"]
            : json["maturityDate"].toString().toValidDate()),
      );

  Map<String, dynamic> toJson() => {
        "fdtype": fdtype,
        "balance": balance,
        "instrumentId": instrumentId,
        "accountNumber": accountNumber,
        "rate": rate,
        "tenure": tenure,
        "cfcurr": cfcurr,
        "convertedActualBalance": convertedActualBalance,
        "openningDate": openningDate,
        "lastRenewalDate": lastRenewalDate,
        "maturityDate": maturityDate,
      };
}
