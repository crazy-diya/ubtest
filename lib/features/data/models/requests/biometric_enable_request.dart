// To parse this JSON data, do
//
//     final biometricEnableRequest = biometricEnableRequestFromJson(jsonString);

import 'dart:convert';

class BiometricEnableRequest {
  BiometricEnableRequest({
    this.messageType,
    this.enableBiometric,
  });

  String? messageType;
  bool? enableBiometric;

  factory BiometricEnableRequest.fromRawJson(String str) => BiometricEnableRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BiometricEnableRequest.fromJson(Map<String, dynamic> json) => BiometricEnableRequest(
    messageType: json["messageType"],
    enableBiometric: json["enableBiometric"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "enableBiometric": enableBiometric,
  };
}
