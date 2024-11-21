// To parse this JSON data, do
//
//     final forgetPwResetRequest = forgetPwResetRequestFromJson(jsonString);

import 'dart:convert';

ForgetPwResetRequest forgetPwResetRequestFromJson(String str) => ForgetPwResetRequest.fromJson(json.decode(str));

String forgetPwResetRequestToJson(ForgetPwResetRequest data) => json.encode(data.toJson());

class ForgetPwResetRequest {
    final String? newPassword;
    final String? confirmPassword;
    final String? messageType;
    final String? epicUserId;
    final String? username;

    ForgetPwResetRequest({
        this.newPassword,
        this.confirmPassword,
        this.messageType,
        this.epicUserId, 
        this.username, 
    });

    factory ForgetPwResetRequest.fromJson(Map<String, dynamic> json) => ForgetPwResetRequest(
        newPassword: json["newPassword"],
        confirmPassword: json["confirmPassword"],
        messageType: json["messageType"],
        epicUserId: json["epicUserId"],
        username: json["username"],
    );

    Map<String, dynamic> toJson() => {
        "newPassword": newPassword,
        "confirmPassword": confirmPassword,
        "messageType": messageType,
        "epicUserId": epicUserId,
        "username": username,
    };
}
