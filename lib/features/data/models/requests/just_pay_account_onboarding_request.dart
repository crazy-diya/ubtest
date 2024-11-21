// To parse this JSON data, do
//
//     final justPayAccountOnboardingRequest = justPayAccountOnboardingRequestFromJson(jsonString);

import 'dart:convert';

JustPayAccountOnboardingRequest justPayAccountOnboardingRequestFromJson(String str) => JustPayAccountOnboardingRequest.fromJson(json.decode(str));

String justPayAccountOnboardingRequestToJson(JustPayAccountOnboardingRequest data) => json.encode(data.toJson());

class JustPayAccountOnboardingRequest {
    final String? messageType;
    final String? obType;
    final String? nic;
    final String? dateOfBirth;
    final String? fullName;
    final String? bankCode;
    final String? accountType;
    final String? accountNo;
    final String? nickName;
    final bool? enableAlert;

    JustPayAccountOnboardingRequest({
        this.messageType,
        this.obType,
        this.nic,
        this.dateOfBirth,
        this.fullName,
        this.bankCode,
        this.accountType,
        this.accountNo,
        this.nickName,
        this.enableAlert,
    });

    factory JustPayAccountOnboardingRequest.fromJson(Map<String, dynamic> json) => JustPayAccountOnboardingRequest(
        messageType: json["messageType"],
        obType: json["obType"],
        nic: json["nic"],
        dateOfBirth: json["dateOfBirth"],
        fullName: json["fullName"],
        bankCode: json["bankCode"],
        accountType: json["accountType"],
        accountNo: json["accountNo"],
        nickName: json["nickName"],
        enableAlert: json["enableAlert"],
    );

    Map<String, dynamic> toJson() => {
        "messageType": messageType,
        "obType": obType,
        "nic": nic,
        "dateOfBirth": dateOfBirth,
        "fullName": fullName,
        "bankCode": bankCode,
        "accountType": accountType,
        "accountNo": accountNo,
        "nickName": nickName,
        "enableAlert": enableAlert,
    };
}
