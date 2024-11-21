// To parse this JSON data, do
//
//     final changePasswordRequest = changePasswordRequestFromJson(jsonString);

import 'dart:convert';

ChangePasswordRequest changePasswordRequestFromJson(String str) => ChangePasswordRequest.fromJson(json.decode(str));

String changePasswordRequestToJson(ChangePasswordRequest data) => json.encode(data.toJson());

class ChangePasswordRequest {
  ChangePasswordRequest({

    this.messageType,
    this.newPassword,
    this.oldPassword,
    this.confirmPassword,
  });

  String? messageType;
  String? newPassword;
  String? oldPassword;
  String? confirmPassword;

  factory ChangePasswordRequest.fromJson(Map<String, dynamic> json) => ChangePasswordRequest(

    messageType: json["messageType"],
    newPassword: json["newPassword"],
    oldPassword: json["oldPassword"],
    confirmPassword: json["confirmPassword"],

  );

  Map<String, dynamic> toJson() => {

    "messageType": messageType,
    "newPassword": newPassword,
    "oldPassword": oldPassword,
    "confirmPassword": confirmPassword,

  };
}
