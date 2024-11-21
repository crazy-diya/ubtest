// To parse this JSON data, do
//
//     final forgetPwCheckUsernameRequest = forgetPwCheckUsernameRequestFromJson(jsonString);

import 'dart:convert';

ForgetPwCheckUsernameRequest forgetPwCheckUsernameRequestFromJson(String str) => ForgetPwCheckUsernameRequest.fromJson(json.decode(str));

String forgetPwCheckUsernameRequestToJson(ForgetPwCheckUsernameRequest data) => json.encode(data.toJson());

class ForgetPwCheckUsernameRequest {
    final String? username;
    final String? identificationType;
    final String? identificationNo;
    final String? messageType;

    ForgetPwCheckUsernameRequest({
        this.username,
        this.identificationType,
        this.identificationNo,
        this.messageType,
    });

    factory ForgetPwCheckUsernameRequest.fromJson(Map<String, dynamic> json) => ForgetPwCheckUsernameRequest(
        username: json["username"],
        identificationType: json["identificationType"],
        identificationNo: json["identificationNo"],
        messageType: json["messageType"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "identificationType": identificationType,
        "identificationNo": identificationNo,
        "messageType": messageType,
    };
}
