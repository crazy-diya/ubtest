// To parse this JSON data, do
//
//     final resetPasswordResponse = resetPasswordResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

ResetPasswordResponse resetPasswordResponseFromJson(String str) => ResetPasswordResponse.fromJson(json.decode(str));

String resetPasswordResponseToJson(ResetPasswordResponse data) => json.encode(data.toJson());

class ResetPasswordResponse extends Serializable{
  final String? messageType;
  final String? epicUserId;

  ResetPasswordResponse({
    this.messageType,
    this.epicUserId,
  });

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) => ResetPasswordResponse(
    messageType: json["messageType"],
    epicUserId: json["epicUserID"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "epicUserID": epicUserId,
  };
}
