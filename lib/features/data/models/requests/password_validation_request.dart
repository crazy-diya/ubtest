// To parse this JSON data, do
//
//     final passwordValidationRequest = passwordValidationRequestFromJson(jsonString);

import 'dart:convert';

PasswordValidationRequest passwordValidationRequestFromJson(String str) => PasswordValidationRequest.fromJson(json.decode(str));

String passwordValidationRequestToJson(PasswordValidationRequest data) => json.encode(data.toJson());

class PasswordValidationRequest {
    String? password;
    String? messageType;

    PasswordValidationRequest({
        this.password,
        this.messageType,
    });

    factory PasswordValidationRequest.fromJson(Map<String, dynamic> json) => PasswordValidationRequest(
        password: json["password"],
        messageType: json["messageType"],
    );

    Map<String, dynamic> toJson() => {
        "password": password,
        "messageType": messageType,
    };
}
