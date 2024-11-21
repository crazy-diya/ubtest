// To parse this JSON data, do
//
//     final resetPasswordRequest = resetPasswordRequestFromJson(jsonString);

import 'dart:convert';

ResetPasswordRequest resetPasswordRequestFromJson(String str) => ResetPasswordRequest.fromJson(json.decode(str));

String resetPasswordRequestToJson(ResetPasswordRequest data) => json.encode(data.toJson());

class ResetPasswordRequest {
  String? messageType;
  String? newPassword;
  String? oldPassword;
  String? confirmPassword;
  final bool isAdminPasswordReset;

  ResetPasswordRequest( {
    this.messageType,
    this.newPassword,
    this.oldPassword,
    this.confirmPassword,
    required this.isAdminPasswordReset,
  });

  factory ResetPasswordRequest.fromJson(Map<String, dynamic> json) => ResetPasswordRequest(
    messageType: json["messageType"],
    newPassword: json["newPassword"],
    oldPassword: json["oldPassword"],
    confirmPassword: json["confirmPassword"], 
    isAdminPasswordReset: json["isAdminPasswordReset"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "newPassword": newPassword,
    "oldPassword": oldPassword,
    "confirmPassword": confirmPassword,
    "isAdminPasswordReset": isAdminPasswordReset,
  };
}
