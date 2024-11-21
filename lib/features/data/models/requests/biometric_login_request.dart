// To parse this JSON data, do
//
//     final biometricLoginRequest = biometricLoginRequestFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class BiometricLoginRequest extends Equatable{
  BiometricLoginRequest({
    this.uniqueCode,
    this.messageType,
  });

  String? uniqueCode;
  String? messageType;

  factory BiometricLoginRequest.fromRawJson(String str) => BiometricLoginRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BiometricLoginRequest.fromJson(Map<String, dynamic> json) => BiometricLoginRequest(
    uniqueCode: json["uniqueCode"],
    messageType: json["messageType"],
  );

  Map<String, dynamic> toJson() => {
    "uniqueCode": uniqueCode,
    "messageType": messageType,
  };
  
  @override
  List<Object?> get props => [uniqueCode,messageType];
}
