import 'dart:convert';



import 'package:union_bank_mobile/features/data/models/requests/schedule_verification_request.dart';

import 'customer_reg_request.dart';
import 'document_verification_request.dart';
import 'emp_detail_request.dart';

WalletOnBoardingData walletOnBoardingDataFromJson(String str) =>
    WalletOnBoardingData.fromJson(json.decode(str));

String walletOnBoardingDataToJson(WalletOnBoardingData data) =>
    json.encode(data.toJson());

class WalletOnBoardingData {
  WalletOnBoardingData({
    this.stepperValue,
    this.walletUserData,
    this.stepperName,
  });

  String? stepperName;
  int? stepperValue;
  WalletUserData? walletUserData;

  factory WalletOnBoardingData.fromJson(Map<String, dynamic> json) =>
      WalletOnBoardingData(
        stepperName: json["stepperName"],
        stepperValue: json["stepperValue"],
        walletUserData: json["walletUserData"] == null
            ? null
            : WalletUserData.fromJson(json["walletUserData"]),
      );

  Map<String, dynamic> toJson() => {
        "stepperName": stepperName,
        "stepperValue": stepperValue,
        "walletUserData":
            walletUserData == null ? null : walletUserData!.toJson(),
      };
}

class WalletUserData {
  WalletUserData(
      {this.customerRegistrationRequest,
      this.empDetailRequest,
      this.documentVerificationRequest, this.scheduleVerificationRequest});

  CustomerRegistrationRequest? customerRegistrationRequest;
  EmpDetailRequest? empDetailRequest;
  DocumentVerificationRequest? documentVerificationRequest;
  ScheduleVerificationRequest? scheduleVerificationRequest;

  factory WalletUserData.fromJson(Map<String, dynamic> json) => WalletUserData(
      customerRegistrationRequest: json["customerRegistrationRequest"] != null
          ? CustomerRegistrationRequest.fromJson(
              json["customerRegistrationRequest"])
          : null,
      empDetailRequest: json["empDetailRequest"] != null
          ? EmpDetailRequest.fromJson(json["empDetailRequest"])
          : null,
      scheduleVerificationRequest: json["scheduleVerificationRequest"] != null
          ? ScheduleVerificationRequest.fromJson(json["scheduleVerificationRequest"])
          : null,
      documentVerificationRequest: json["documentVerificationRequest"] != null
          ? DocumentVerificationRequest.fromJson(
              json["documentVerificationRequest"])
          : null);

  Map<String, dynamic> toJson() => {
        "customerRegistrationRequest": customerRegistrationRequest != null
            ? customerRegistrationRequest!.toJson()
            : null,
        "empDetailRequest":
            empDetailRequest != null ? empDetailRequest!.toJson() : null,
        "documentVerificationRequest": documentVerificationRequest != null
            ? documentVerificationRequest!.toJson()
            : null,
    "scheduleVerificationRequest": scheduleVerificationRequest != null
            ? scheduleVerificationRequest!.toJson()
            : null,
      };
}
