// To parse this JSON data, do
//
//     final deviceInfoRequestModel = deviceInfoRequestModelFromJson(jsonString);

import 'dart:convert';

DeviceInfoRequest deviceInfoRequestModelFromJson(String str) => DeviceInfoRequest.fromJson(json.decode(str));

String deviceInfoRequestModelToJson(DeviceInfoRequest data) => json.encode(data.toJson());

class DeviceInfoRequest {
  DeviceInfoRequest({
    this.dv,
    this.dd,
  });

  String? dv;
  Dd? dd;

  factory DeviceInfoRequest.fromJson(Map<String, dynamic> json) => DeviceInfoRequest(
        dv: json["DV"],
        dd: Dd.fromJson(json["DD"]),
      );

  Map<String, dynamic> toJson() => {
        "DV": dv,
        "DD": dd!.toJson(),
      };
}

class Dd {
  Dd({
    this.platform = "",
    this.deviceModel = "",
    this.osName = "",
    this.osVersion = "",
    this.locale = "",
    this.timeZone = "",
    this.screenResolution = "",
    this.deviceName = "",
    this.ip = "",
    this.latitude = "",
    this.longitude = "",
    this.deviceId = "",
    this.pushId = "",
    this.channelType ="",
    this.deviceBrand = ""
  });

  String? platform;
  String? deviceModel;
  String? osName;
  String? osVersion;
  String? locale;
  String? timeZone;
  String? screenResolution;
  String? deviceName;
  String? ip;
  String? latitude;
  String? longitude;
  String? deviceId;
  String? pushId;
  String? channelType;
  String? deviceBrand;

  factory Dd.fromJson(Map<String, dynamic> json) => Dd(
        platform: json["platform"],
        deviceModel: json["deviceModel"],
        osName: json["osName"],
        osVersion: json["osVersion"],
        locale: json["locale"],
        timeZone: json["timeZone"],
        screenResolution: json["screenResolution"],
        deviceName: json["deviceName"],
        ip: json["ip"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        deviceId: json["deviceId"],
        pushId: json["pushId"],
        channelType: json["channelType"],
        deviceBrand: json["deviceBrand"]
      );

  Map<String, dynamic> toJson() => {
        "platform": platform,
        "deviceModel": deviceModel,
        "osName": osName,
        "osVersion": osVersion,
        "locale": locale,
        "timeZone": timeZone,
        "screenResolution": screenResolution,
        "deviceName": deviceName,
        "ip": ip,
        "latitude": latitude,
        "longitude": longitude,
        "deviceId": deviceId,
        "pushId": pushId,
        "channelType": channelType,
        "deviceBrand":deviceBrand
      };
}
