

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';

PortfolioLoanDetailsResponse portfolioLoanDetailsResponseFromJson(String str) => PortfolioLoanDetailsResponse.fromJson(json.decode(str));

String portfolioLoanDetailsResponseToJson(PortfolioLoanDetailsResponse data) => json.encode(data.toJson());

class PortfolioLoanDetailsResponse extends Serializable{
    final num? totalOutStandingBalance;
    final List<LoanDetailsResponseDtoList>? loanDetailsResponseDtoList;

    PortfolioLoanDetailsResponse({
        this.totalOutStandingBalance,
        this.loanDetailsResponseDtoList,
    });

    factory PortfolioLoanDetailsResponse.fromJson(Map<String, dynamic> json) => PortfolioLoanDetailsResponse(
        totalOutStandingBalance: json["totalOutStandingBalance"],
        loanDetailsResponseDtoList: json["accountDetailsResponseDTOS"] == null ? [] : List<LoanDetailsResponseDtoList>.from(json["accountDetailsResponseDTOS"]!.map((x) => LoanDetailsResponseDtoList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "totalOutStandingBalance": totalOutStandingBalance,
        "accountDetailsResponseDTOS": loanDetailsResponseDtoList == null ? [] : List<dynamic>.from(loanDetailsResponseDtoList!.map((x) => x.toJson())),
    };
}

class LoanDetailsResponseDtoList {
    final String? respoNseCode;
    final int? instrumentId;
    final String? maturityDate;
    final String? loanName;
    final String? loanAccountNo;
    final String? outStandingBalance;
    final String? nextInstallmentDate;
    final String? nextInstallmentAmount;
    final String? agreementBranch;
    final String? agreementStartDate;
    final String? aggreementMaturityDate;
    final String? loanPeriodInMonths;
    final String? facilityAmount;
    final String? charges;
    final String? numberOfFutureRentals;
    final String? numberOfRentalsArrears;
    final String? productCode;
    final String? interestType;
    final String? currentInterestRate;
    final String? totalArreas;
    final String? cfcurr;

    LoanDetailsResponseDtoList({
        this.respoNseCode,
        this.instrumentId,
        this.maturityDate,
        this.loanName,
        this.loanAccountNo,
        this.outStandingBalance,
        this.nextInstallmentDate,
        this.nextInstallmentAmount,
        this.agreementBranch,
        this.agreementStartDate,
        this.aggreementMaturityDate,
        this.loanPeriodInMonths,
        this.facilityAmount,
        this.charges,
        this.numberOfFutureRentals,
        this.numberOfRentalsArrears,
        this.productCode,
        this.interestType,
        this.currentInterestRate,
        this.totalArreas,
        this.cfcurr,
    });

    factory LoanDetailsResponseDtoList.fromJson(Map<String, dynamic> json) => LoanDetailsResponseDtoList(
        respoNseCode: json["respoNseCode"],
        instrumentId: json["instrumentId"],
        maturityDate:  json["maturityDate"].toString().isDate() == true
            ? json["maturityDate"]
            : json["maturityDate"].toString().toValidDate(),
        loanName: json["loanName"],
        loanAccountNo: json["loanAccountNo"],
        outStandingBalance: json["outStandingBalance"],
        nextInstallmentDate:  json["nextInstallmentDate"].toString().isDate() == true
            ? json["nextInstallmentDate"]
            : json["nextInstallmentDate"].toString().toValidDate(),
        nextInstallmentAmount: json["nextInstallmentAmount"],
        agreementBranch: json["agreementBranch"],
        agreementStartDate: json["agreementStartDate"].toString().isDate() == true
            ? json["agreementStartDate"]
            : json["agreementStartDate"].toString().toValidDate(),
        aggreementMaturityDate:  json["aggreementMaturityDate"].toString().isDate() == true
            ? json["aggreementMaturityDate"]
            : json["aggreementMaturityDate"].toString().toValidDate(),
        loanPeriodInMonths: json["loanPeriodInMonths"],
        facilityAmount: json["facilityAmount"],
        charges: json["charges"],
        numberOfFutureRentals: json["numberOfFutureRentals"],
        numberOfRentalsArrears: json["numberOfRentalsArrears"],
        productCode: json["productCode"],
        interestType: json["interestType"],
        currentInterestRate: json["currentInterestRate"],
        totalArreas: json["totalArreas"],
        cfcurr: json["cfcurr"].toString().trim(),
    );

    Map<String, dynamic> toJson() => {
        "respoNseCode": respoNseCode,
        "instrumentId": instrumentId,
        "maturityDate": maturityDate,
        "loanName": loanName,
        "loanAccountNo": loanAccountNo,
        "outStandingBalance": outStandingBalance,
        "nextInstallmentDate": nextInstallmentDate,
        "nextInstallmentAmount": nextInstallmentAmount,
        "agreementBranch": agreementBranch,
        "agreementStartDate": agreementStartDate,
        "aggreementMaturityDate": aggreementMaturityDate,
        "loanPeriodInMonths": loanPeriodInMonths,
        "facilityAmount": facilityAmount,
        "charges": charges,
        "numberOfFutureRentals": numberOfFutureRentals,
        "numberOfRentalsArrears": numberOfRentalsArrears,
        "productCode": productCode,
        "interestType": interestType,
        "currentInterestRate": currentInterestRate,
        "totalArreas": totalArreas,
        "cfcurr": cfcurr,
    };
}





