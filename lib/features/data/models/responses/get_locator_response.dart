// To parse this JSON data, do
//
//     final merchantLocatorResponse = merchantLocatorResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

MerchantLocatorResponse merchantLocatorResponseFromJson(String str) => MerchantLocatorResponse.fromJson(json.decode(str));

String merchantLocatorResponseToJson(MerchantLocatorResponse data) => json.encode(data.toJson());

class MerchantLocatorResponse extends Serializable{
  List<Atm>? atm;
  List<Atm>? branch;
  List<Atm>? cdm;

  MerchantLocatorResponse({
    this.atm,
    this.branch,
    this.cdm,
  });

  factory MerchantLocatorResponse.fromJson(Map<String, dynamic> json) => MerchantLocatorResponse(
    atm: json["atm"] == null ? [] : List<Atm>.from(json["atm"]!.map((x) => Atm.fromJson(x))),
    branch: json["branch"] == null ? [] : List<Atm>.from(json["branch"]!.map((x) => Atm.fromJson(x))),
    cdm: json["cdm"] == null ? [] : List<Atm>.from(json["cdm"]!.map((x) => Atm.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "atm": atm == null ? [] : List<dynamic>.from(atm!.map((x) => x.toJson())),
    "branch": branch == null ? [] : List<dynamic>.from(branch!.map((x) => x.toJson())),
    "cdm": cdm == null ? [] : List<dynamic>.from(cdm!.map((x) => x.toJson())),
  };
}

class Atm {
  int? id;
  String? name;
  String? address;
  double? longitude;
  double? latitude;
  String? contactNo;
  String? locationCategory;
  int? startDayOfWeek;
  int? endDayOfWeek;
  String? startTime;
  String? endTime;
  String? status;
  List<String>? services;
  String? email;
  String? city;
  String? landMark;

  Atm({
    this.id,
    this.name,
    this.address,
    this.longitude,
    this.latitude,
    this.contactNo,
    this.locationCategory,
    this.startDayOfWeek,
    this.endDayOfWeek,
    this.startTime,
    this.endTime,
    this.status,
    this.services,
    this.email,
    this.city,
    this.landMark,
  });

  factory Atm.fromJson(Map<String, dynamic> json) => Atm(
    id: json["id"],
    name: json["name"],
    landMark: json["landMark"],
    address: json["address"],
    longitude: json["longitude"]?.toDouble(),
    latitude: json["latitude"]?.toDouble(),
    contactNo: json["contactNo"],
    locationCategory: json["locationCategory"],
    startDayOfWeek: json["startDayOfWeek"],
    endDayOfWeek: json["endDayOfWeek"],
    startTime: json["startTime"],
    endTime: json["endTime"],
    status: json["status"],
    services: json["services"] == null ? [] : List<String>.from(json["services"]!.map((x) => x)),
    email: json["email"],
    city: json["city"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "address": address,
    "landMark": landMark,
    "longitude": longitude,
    "latitude": latitude,
    "contactNo": contactNo,
    "locationCategory": locationCategory,
    "startDayOfWeek": startDayOfWeek,
    "endDayOfWeek": endDayOfWeek,
    "startTime": startTime,
    "endTime": endTime,
    "status": status,
    "services": services == null ? [] : List<dynamic>.from(services!.map((x) => x)),
    "email": email,
    "city": city,
  };
}
