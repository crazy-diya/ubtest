// To parse this JSON data, do
//
//     final settingsTranLimitRequest = settingsTranLimitRequestFromJson(jsonString);

import 'dart:convert';

SettingsTranLimitRequest settingsTranLimitRequestFromJson(String str) => SettingsTranLimitRequest.fromJson(json.decode(str));

String settingsTranLimitRequestToJson(SettingsTranLimitRequest data) => json.encode(data.toJson());

class SettingsTranLimitRequest {
  String? messageType;
  String? channelType;

  SettingsTranLimitRequest({
    this.messageType,
    this.channelType,
  });

  factory SettingsTranLimitRequest.fromJson(Map<String, dynamic> json) => SettingsTranLimitRequest(
    messageType: json["messageType"],
    channelType: json["channelType"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "channelType": channelType,
  };
}
