// To parse this JSON data, do
//
//     final splashResponse = splashResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

SplashResponse splashResponseFromJson(String str) =>
    SplashResponse.fromJson(json.decode(str));

String splashResponseToJson(SplashResponse data) => json.encode(data.toJson());

class SplashResponse extends Serializable {
  SplashResponse({
    this.forceUpdate,
    this.mandatoryUpdate,
    this.userNamePolicy,
    this.passwordPolicy,
    this.obTypeDataList,
    this.bankDataList,
    this.ratesUrl,
    this.seatReservationUrl,
    this.optionalUpdate,
     this.companyDetails,
  });

  bool? forceUpdate;
  bool? optionalUpdate;
  String? ratesUrl;
  String? seatReservationUrl;
  bool? mandatoryUpdate;
  UserNamePolicy? userNamePolicy;
  PasswordPolicy? passwordPolicy;
  List<ObTypes>? obTypeDataList;
  List<BankDataList>? bankDataList;
 List<CompanyDetail>? companyDetails;

  factory SplashResponse.fromJson(Map<String, dynamic> json) => SplashResponse(
        forceUpdate: json["forceUpdate"],
        optionalUpdate:json["optionalUpdate"],
    ratesUrl: json["ratesUrl"],
    seatReservationUrl: json["seatReservationUrl"],
        mandatoryUpdate: json["mandatoryUpdate"],
        companyDetails: json["companyDetails"] == null ? [] : List<CompanyDetail>.from(json["companyDetails"]!.map((x) => CompanyDetail.fromJson(x))),
        userNamePolicy: UserNamePolicy.fromJson(json["userNamePolicy"]),
        passwordPolicy: PasswordPolicy.fromJson(json["passwordPolicy"]),
    obTypeDataList: List<ObTypes>.from(json["obTypeDataList"].map((x) => ObTypes.fromJson(x))),
    bankDataList: List<BankDataList>.from(json["bankDataList"].map((x) => BankDataList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "forceUpdate": forceUpdate,
        "optionalUpdate":optionalUpdate,
        "ratesUrl": ratesUrl,
    "seatReservationUrl": seatReservationUrl,
        "mandatoryUpdate": mandatoryUpdate,
        "companyDetails": companyDetails == null ? [] : List<dynamic>.from(companyDetails!.map((x) => x.toJson())),
        "userNamePolicy": userNamePolicy!.toJson(),
        "passwordPolicy": passwordPolicy!.toJson(),
        "obTypeDataList": List<dynamic>.from(obTypeDataList!.map((x) => x.toJson())),
        "bankDataList": List<dynamic>.from(bankDataList!.map((x) => x.toJson())),
      };
}

class CompanyDetail {
    final int? id;
    final String? code;
    final String? description;
    final String? value;
    final String? status;
    final DateTime? createdDate;
    final String? createdUser;
    final DateTime? modifiedDate;
    final String? modifiedUser;

    CompanyDetail({
        this.id,
        this.code,
        this.description,
        this.value,
        this.status,
        this.createdDate,
        this.createdUser,
        this.modifiedDate,
        this.modifiedUser,
    });

    factory CompanyDetail.fromJson(Map<String, dynamic> json) => CompanyDetail(
        id: json["id"],
        code: json["code"],
        description: json["description"],
        value: json["value"],
        status: json["status"],
        createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
        createdUser: json["createdUser"],
        modifiedDate: json["modifiedDate"] == null ? null : DateTime.parse(json["modifiedDate"]),
        modifiedUser: json["modifiedUser"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "description": description,
        "value": value,
        "status": status,
        "createdDate": createdDate?.toIso8601String(),
        "createdUser": createdUser,
        "modifiedDate": modifiedDate?.toIso8601String(),
        "modifiedUser": modifiedUser,
    };
}

class ObTypes {
  ObTypes({
    this.code,
    this.description,
  });

  String? code;
  String? description;

  factory ObTypes.fromJson(Map<String, dynamic> json) => ObTypes(
        code: json["code"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "description": description,
      };
}

class BankDataList{

  BankDataList({
    this.bankCode,
    this.ceftCode,
    this.description,
});

  String? bankCode;
  String? description;
  String? ceftCode;

  factory BankDataList.fromJson(Map<String, dynamic> json) => BankDataList(
    bankCode: json["bankCode"],
    description: json["description"],
    ceftCode: json["ceftCode"],
  );

  Map<String, dynamic> toJson() => {
    "bankCode": bankCode,
    "ceftCode": ceftCode,
    "description": description,
  };

}

class PasswordPolicy {
  PasswordPolicy({
    this.minLength,
    this.maxLength,
    this.minimumSpecialChars,
    this.minimumUpperCaseChars,
    this.minimumLowercaseChars,
    this.minimumNumericalChars,
    this.invalidLoginAttempts,
    this.repeatedChars,
    this.initialPasswordExpiryStatus,
    this.noOfHistoryPasswords,
    this.minimumPasswordChangeNotifyPeriod,
  });

  int? minLength;
  int? maxLength;
  int? minimumSpecialChars;
  int? minimumUpperCaseChars;
  int? minimumLowercaseChars;
  int? minimumNumericalChars;
  int? invalidLoginAttempts;
  int? repeatedChars;
  int? initialPasswordExpiryStatus;
  int? noOfHistoryPasswords;
  int? minimumPasswordChangeNotifyPeriod;

  factory PasswordPolicy.fromJson(Map<String, dynamic> json) => PasswordPolicy(
        minLength: json["minLength"],
        maxLength: json["maxLength"],
        minimumSpecialChars: json["minimumSpecialChars"],
        minimumUpperCaseChars: json["minimumUpperCaseChars"],
        minimumLowercaseChars: json["minimumLowercaseChars"],
        minimumNumericalChars: json["minimumNumericalChars"],
        invalidLoginAttempts: json["invalidLoginAttempts"],
        repeatedChars: json["repeatedChars"],
        initialPasswordExpiryStatus: json["initialPasswordExpiryStatus"],
        noOfHistoryPasswords: json["noOfHistoryPasswords"],
        minimumPasswordChangeNotifyPeriod:
            json["minimumPasswordChangeNotifyPeriod"],
      );

  Map<String, dynamic> toJson() => {
        "minLength": minLength,
        "maxLength": maxLength,
        "minimumSpecialChars": minimumSpecialChars,
        "minimumUpperCaseChars": minimumUpperCaseChars,
        "minimumLowercaseChars": minimumLowercaseChars,
        "minimumNumericalChars": minimumNumericalChars,
        "invalidLoginAttempts": invalidLoginAttempts,
        "repeatedChars": repeatedChars,
        "initialPasswordExpiryStatus": initialPasswordExpiryStatus,
        "noOfHistoryPasswords": noOfHistoryPasswords,
        "minimumPasswordChangeNotifyPeriod": minimumPasswordChangeNotifyPeriod,
      };
}

class UserNamePolicy {
  UserNamePolicy({
    this.minLength,
    this.maxLength,
    this.minimumSpecialChars,
    this.minimumUpperCaseChars,
    this.minimumLowercaseChars,
    this.minimumNumericalChars,
    this.repeatedChars,
  });

  int? minLength;
  int? maxLength;
  int? minimumSpecialChars;
  int? minimumUpperCaseChars;
  int? minimumLowercaseChars;
  int? minimumNumericalChars;
  int? repeatedChars;

  factory UserNamePolicy.fromJson(Map<String, dynamic> json) => UserNamePolicy(
        minLength: json["minLength"],
        maxLength: json["maxLength"],
        minimumSpecialChars: json["minimumSpecialChars"],
        minimumUpperCaseChars: json["minimumUpperCaseChars"],
        minimumLowercaseChars: json["minimumLowercaseChars"],
        minimumNumericalChars: json["minimumNumericalChars"],
        repeatedChars: json["repeatedChars"],
      );

  Map<String, dynamic> toJson() => {
        "minLength": minLength,
        "maxLength": maxLength,
        "minimumSpecialChars": minimumSpecialChars,
        "minimumUpperCaseChars": minimumUpperCaseChars,
        "minimumLowercaseChars": minimumLowercaseChars,
        "minimumNumericalChars": minimumNumericalChars,
        "repeatedChars": repeatedChars,
      };
}
