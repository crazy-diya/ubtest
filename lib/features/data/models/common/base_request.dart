// To parse this JSON data, do
//
//     final baseRequest = baseRequestFromJson(jsonString);

import 'dart:convert';

BaseRequest baseRequestFromJson(String str) =>
    BaseRequest.fromJson(json.decode(str));

String baseRequestToJson(BaseRequest data) => json.encode(data.toJson());

class BaseRequest {
  BaseRequest(
      {this.deviceChannel,
      this.messageVersion,
      this.deviceInfo,
      this.epicTransId,
      this.epicUserId,
      this.appId,
      this.appMaxTimeout,
      this.appReferenceNumber,
      this.appTransId,
      this.ghostId,
      this.deviceId,
      this.timestamp,
      this.isMigrated,
      });

  String? deviceChannel;
  String? messageVersion;
  String? deviceInfo;
  String? deviceId;
  String? epicTransId;
  String? epicUserId;
  String? messageType;
  String? appId;
  String? appMaxTimeout;
  String? appReferenceNumber;
  String? appTransId;
  String? ghostId;
  String? timestamp;
  String? isMigrated;
  

  factory BaseRequest.fromJson(Map<String, dynamic> json) => BaseRequest(
        deviceChannel: json["deviceChannel"],
        messageVersion: json["messageVersion"],
        deviceInfo: json["deviceInfo"],
        epicTransId: json["epicTransId"],
        epicUserId: json["epicUserId"],
        deviceId: json["deviceId"],
        appId: json["appID"],
        appMaxTimeout: json["appMaxTimeout"],
        appReferenceNumber: json["appReferenceNumber"],
        appTransId: json["appTransID"],
        ghostId: json["ghostId"],
        timestamp:json["timestamp"],
        isMigrated:json["isMigrated"]
      );

  Map<String, dynamic> toJson() => {
        "deviceChannel": deviceChannel,
        "messageVersion": messageVersion,
        "deviceInfo": deviceInfo,
        "epicTransId": epicTransId,
        "epicUserId": epicUserId,
        "deviceId": deviceId,
        "appID": appId,
        "appMaxTimeout": appMaxTimeout,
        //"appReferenceNumber": appReferenceNumber,
        "appReferenceNumber": appReferenceNumber,
        "appTransID": appTransId,
        //"ghostId": "dd461dbb-80b1-4fa8-8523-06577bad281b",
        "ghostId": ghostId,
        "timestamp":timestamp,
        "isMigrated":isMigrated
      };
}
