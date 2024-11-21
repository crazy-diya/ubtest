// To parse this JSON data, do
//
//     final demoTourResponse = demoTourResponseFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:union_bank_mobile/features/data/models/common/base_response.dart';
DemoTourListResponse securityQuestionResponseFromJson(String str) =>
    DemoTourListResponse.fromJson(json.decode(str));

String securityQuestionResponseToJson(DemoTourListResponse data) =>
    json.encode(data.toJson());

class DemoTourListResponse extends Serializable {
  DemoTourListResponse({
    this.data,
  });

  final List<DemoTourResponse>? data;

  factory DemoTourListResponse.fromJson(Map<String, dynamic> json) =>
      DemoTourListResponse(
        data: List<DemoTourResponse>.from(
            json["data"].map((x) => DemoTourResponse.fromJson(x))),
      );

  @override
  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}


DemoTourResponse demoTourResponseFromJson(String str) => DemoTourResponse.fromJson(json.decode(str));

String demoTourResponseToJson(DemoTourResponse data) => json.encode(data.toJson());

class DemoTourResponse {
    int? id;
    String? title;
    String? link;
    String? thumbnailImageKey;
    Uint8List? image;
    Uint8List? icon;
    String? status;
    String? createdUser;
    DateTime? createdDate;
    DateTime? modifiedDate;
    String? modifiedUser;
    String? iconUrl;

    DemoTourResponse({
        this.id,
        this.title,
        this.link,
        this.thumbnailImageKey,
        this.image,
        this.icon,
        this.status,
        this.createdUser,
        this.createdDate,
        this.modifiedDate,
        this.modifiedUser,
        this.iconUrl,
    });

    factory DemoTourResponse.fromJson(Map<String, dynamic> json) => DemoTourResponse(
        id: json["id"],
        title: json["title"],
        link: json["link"],
        thumbnailImageKey: json["thumbnailImageKey"],
        image:  base64.decode(json["image"]??""),
        icon: base64.decode(json["icon"] ?? ""),
        status: json["status"],
        createdUser: json["createdUser"],
        createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
        modifiedDate: json["modifiedDate"] == null ? null : DateTime.parse(json["modifiedDate"]),
        modifiedUser: json["modifiedUser"],
        iconUrl: json["iconUrl"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "link": link,
        "thumbnailImageKey": thumbnailImageKey,
        "image": image,
        "icon": icon,
        "status": status,
        "createdUser": createdUser,
        "createdDate": createdDate?.toIso8601String(),
        "modifiedDate": modifiedDate?.toIso8601String(),
        "modifiedUser": modifiedUser,
        "iconUrl": iconUrl,
    };
}


