// // To parse this JSON data, do
// //
// //     final accountDetailsResponseDtos = accountDetailsResponseDtosFromJson(jsonString);

// import 'dart:convert';

// import '../common/base_response.dart';

// AccountDetailsResponseDtos accountDetailsResponseDtosFromJson(String str) =>
//     AccountDetailsResponseDtos.fromJson(json.decode(str));

// String accountDetailsResponseDtosToJson(AccountDetailsResponseDtos data) =>
//     json.encode(data.toJson());

// class AccountDetailsResponseDtos extends Serializable {
//   List<AccountDetailsResponseDto>? accountDetailsResponseDtos;

//   AccountDetailsResponseDtos({
//      this.accountDetailsResponseDtos,
//   });

//   factory AccountDetailsResponseDtos.fromJson(Map<String, dynamic> json) =>
//       AccountDetailsResponseDtos(
//         accountDetailsResponseDtos: List<AccountDetailsResponseDto>.from(
//             json["accountDetailsResponseDTOS"]
//                 .map((x) => AccountDetailsResponseDto.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "accountDetailsResponseDTOS": List<dynamic>.from(
//             accountDetailsResponseDtos!.map((x) => x.toJson())),
//       };
// }

// class AccountDetailsResponseDto {
//   String? productType;
//   int? instrumentId;
//   String? productName;
//   String? branchName;
//   String? accountNumber;
//   String? availableBalance;
//   String? actualBalance;
//   String? overDraftedLimit;
//   String? unclearedBalance;
//   String? openedDate;
//   String? status;
//   String? nickName;
//   String? holdBalance;
//   String? effectiveInterestRate;
//   String? bankName;
//   String? bankCode;
//   String? accountType;


//   AccountDetailsResponseDto({
//      this.productType,
//      this.productName,
//      this.branchName,
//      this.accountNumber,
//      this.availableBalance,
//      this.actualBalance,
//      this.overDraftedLimit,
//      this.unclearedBalance,
//      this.openedDate,
//      this.status,
//      this.instrumentId,
//      this.nickName,
//      this.holdBalance,
//      this.effectiveInterestRate,
//      this.bankName,
//      this.bankCode,
//      this.accountType

//   });

//   factory AccountDetailsResponseDto.fromJson(Map<String, dynamic> json) =>
//       AccountDetailsResponseDto(
//         productType: json["productType"],
//         productName: json["productName"],
//         branchName: json["branchName"],
//         accountNumber: json["accountNumber"],
//         availableBalance: json["availableBalance"],
//         actualBalance: json["actualBalance"],
//         overDraftedLimit: json["overDraftedLimit"],
//         unclearedBalance: json["unclearedBalance"],
//         openedDate: json["openedDate"],
//         status: json["status"],
//         nickName: json["nickName"],
//         instrumentId: json["instrumentId"],
//         holdBalance: json["holdBalance"],
//         effectiveInterestRate: json["effectiveInterestRate"],
//         bankName: json["bankName"],
//         bankCode: json["bankCode"],
//         accountType:json["accountType"]

//       );

//   Map<String, dynamic> toJson() => {
//         "productType": productType,
//         "productName": productName,
//         "branchName": branchName,
//         "accountNumber": accountNumber,
//         "availableBalance": availableBalance,
//         "actualBalance": actualBalance,
//         "overDraftedLimit": overDraftedLimit,
//         "unclearedBalance": unclearedBalance,
//         "openedDate": openedDate,
//         "status": status,
//         "nickName": nickName,
//         "instrumentId": instrumentId,
//         "holdBalance": holdBalance,
//         "effectiveInterestRate": effectiveInterestRate,
//         "bankName": bankName,
//         "bankCode": bankCode,
//         "accountType":accountType

//       };
// }




// To parse this JSON data, do
//
//     final accountDetailsResponseDtos = accountDetailsResponseDtosFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

AccountDetailsResponseDtos accountDetailsResponseDtosFromJson(String str) => AccountDetailsResponseDtos.fromJson(json.decode(str));

String accountDetailsResponseDtosToJson(AccountDetailsResponseDtos data) => json.encode(data.toJson());

class AccountDetailsResponseDtos extends Serializable {
    final List<AccountDetailsResponseDto>? accountDetailsResponseDtos;

    AccountDetailsResponseDtos({
        this.accountDetailsResponseDtos,
    });

    factory AccountDetailsResponseDtos.fromJson(Map<String, dynamic> json) => AccountDetailsResponseDtos(
        accountDetailsResponseDtos: json["accountDetailsResponseDTOS"] == null ? [] : List<AccountDetailsResponseDto>.from(json["accountDetailsResponseDTOS"]!.map((x) => AccountDetailsResponseDto.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "accountDetailsResponseDTOS": accountDetailsResponseDtos == null ? [] : List<dynamic>.from(accountDetailsResponseDtos!.map((x) => x.toJson())),
    };
}

class AccountDetailsResponseDto {
  String? productType;
  int? instrumentId;
  String? productName;
  String? branchName;
  String? accountNumber;
  String? availableBalance;
  String? actualBalance;
  String? overDraftedLimit;
  String? unclearedBalance;
  String? openedDate;
  String? status;
  String? nickName;
  String? holdBalance;
  String? effectiveInterestRate;
  String? bankName;
  String? bankCode;
  String? accountType;
  String? cfprcd;
  String? cfcurr;
  String? convertedActualBalance;


  AccountDetailsResponseDto({
     this.productType,
     this.productName,
     this.branchName,
     this.accountNumber,
     this.availableBalance,
     this.actualBalance,
     this.overDraftedLimit,
     this.unclearedBalance,
     this.openedDate,
     this.status,
     this.instrumentId,
     this.nickName,
     this.holdBalance,
     this.effectiveInterestRate,
     this.bankName,
     this.bankCode,
     this.accountType,
     this.cfprcd,
     this.cfcurr,
     this.convertedActualBalance

  });

  factory AccountDetailsResponseDto.fromJson(Map<String, dynamic> json) =>
      AccountDetailsResponseDto(
        productType: json["productType"],
        productName: json["productName"],
        branchName: json["branchName"],
        accountNumber: json["accountNumber"],
        availableBalance: json["availableBalance"],
        actualBalance: json["actualBalance"],
        overDraftedLimit: json["overDraftedLimit"],
        unclearedBalance: json["unclearedBalance"],
        openedDate: json["openedDate"],
        status: json["status"],
        nickName: json["nickName"],
        instrumentId: json["instrumentId"],
        holdBalance: json["holdBalance"],
        effectiveInterestRate: json["effectiveInterestRate"],
        bankName: json["bankName"],
        bankCode: json["bankCode"],
        accountType:json["accountType"],
        cfprcd:json["cfprcd"],
        cfcurr:json["cfcurr"].toString().trim(),
        convertedActualBalance:json["convertedActualBalance"]
      );

  Map<String, dynamic> toJson() => {
        "productType": productType,
        "productName": productName,
        "branchName": branchName,
        "accountNumber": accountNumber,
        "availableBalance": availableBalance,
        "actualBalance": actualBalance,
        "overDraftedLimit": overDraftedLimit,
        "unclearedBalance": unclearedBalance,
        "openedDate": openedDate,
        "status": status,
        "nickName": nickName,
        "instrumentId": instrumentId,
        "holdBalance": holdBalance,
        "effectiveInterestRate": effectiveInterestRate,
        "bankName": bankName,
        "bankCode": bankCode,
        "accountType":accountType,
        "cfprcd":cfprcd,
        "cfcurr":cfcurr,
        "convertedActualBalance":convertedActualBalance
      };
}

