// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final cityDetailResponse = cityDetailResponseFromJson(jsonString);

import 'dart:convert';


import '../common/base_response.dart';

CityDetailResponse cityDetailResponseFromJson(String str) =>
    CityDetailResponse.fromJson(json.decode(str));

String cityDetailResponseToJson(CityDetailResponse data) =>
    json.encode(data.toJson());

class CityDetailResponse extends Serializable {
  CityDetailResponse({
    this.data,
  });

  final List<CommonDropDownResponse>? data;

  factory CityDetailResponse.fromJson(Map<String, dynamic> json) =>
      CityDetailResponse(
        data: List<CommonDropDownResponse>.from(
            json["data"].map((x) => CommonDropDownResponse.fromJson(x))),
      );

  @override
  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CommonDropDownResponse {
  CommonDropDownResponse( {this.id, this.description, this.key, this.code,this.icon,});

  final int? id;
  final String? description;
  final String? key;
  final String? code;
  final String? icon;

  factory CommonDropDownResponse.fromJson(Map<String, dynamic> json) =>
      CommonDropDownResponse(
        id: json["id"],
        description: json["description"],
        code: json["code"],
         icon: json["icon"]??"",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "code": code,
        "icon": icon,
      };

  @override
  String toString() {
    return 'CommonDropDownResponse(id: $id, description: $description, key: $key, code: $code, icon: $icon)';
  }

  @override
  bool operator ==(covariant CommonDropDownResponse other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.description == description &&
      other.key == key &&
      other.code == code &&
      other.icon == icon;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      description.hashCode ^
      key.hashCode ^
      code.hashCode ^
      icon.hashCode;
  }
}
