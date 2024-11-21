// To parse this JSON data, do
//
//     final passwordValidationResponse = passwordValidationResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

PasswordValidationResponse passwordValidationResponseFromJson(String str) => PasswordValidationResponse.fromJson(json.decode(str));

String passwordValidationResponseToJson(PasswordValidationResponse data) => json.encode(data.toJson());

class PasswordValidationResponse extends Serializable{
    String? status;
    String? message;

    PasswordValidationResponse({
        this.status,
        this.message,
    });

    factory PasswordValidationResponse.fromJson(Map<String, dynamic> json) => PasswordValidationResponse(
        status: json["status"],
        message: json["message"],
    );

    @override
      Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
