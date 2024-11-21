// To parse this JSON data, do
//
//     final forgotPasswordFromAccountRequest = forgotPasswordFromAccountRequestFromJson(jsonString);

import 'dart:convert';

ForgetPwCheckNicAccountRequest forgotPasswordFromAccountRequestFromJson(String str) => ForgetPwCheckNicAccountRequest.fromJson(json.decode(str));

String forgotPasswordFromAccountRequestToJson(ForgetPwCheckNicAccountRequest data) => json.encode(data.toJson());

class ForgetPwCheckNicAccountRequest {
    final String? accountNumber;
    final String? identificationType;
    final String? identificationNo;
    final String? messageType;

    ForgetPwCheckNicAccountRequest({
        this.accountNumber,
        this.identificationNo,
        this.identificationType,
        this.messageType,
    });

    factory ForgetPwCheckNicAccountRequest.fromJson(Map<String, dynamic> json) => ForgetPwCheckNicAccountRequest(
        accountNumber: json["accountNumber"],
        identificationNo: json["identificationNo"],
        identificationType: json["identificationType"],
        messageType: json["messageType"],
    );

    Map<String, dynamic> toJson() => {
        "accountNumber": accountNumber,
        "identificationNo": identificationNo,
        "identificationType": identificationType,
        "messageType": messageType,
    };
}
