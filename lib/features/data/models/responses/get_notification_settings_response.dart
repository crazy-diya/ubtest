// To parse this JSON data, do
//
//     final getNotificationSettingsResponse = getNotificationSettingsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

GetNotificationSettingsResponse getNotificationSettingsResponseFromJson(
        String str) =>
    GetNotificationSettingsResponse.fromJson(json.decode(str));

String getNotificationSettingsResponseToJson(
        GetNotificationSettingsResponse data) =>
    json.encode(data.toJson());

class GetNotificationSettingsResponse extends Serializable {
  final bool? smsSettings;
  final bool? emailSettings;

  GetNotificationSettingsResponse({
    this.smsSettings,
    this.emailSettings,
  });

  factory GetNotificationSettingsResponse.fromJson(Map<String, dynamic> json) =>
      GetNotificationSettingsResponse(
        smsSettings: json["smsSettings"],
        emailSettings: json["emailSettings"],
      );

  Map<String, dynamic> toJson() => {
        "smsSettings": smsSettings,
        "emailSettings": emailSettings,
      };
}
