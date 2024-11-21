// To parse this JSON data, do
//
//     final getOtherProductsResponse = getOtherProductsResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

class GetOtherProductsResponse extends Serializable{
  GetOtherProductsResponse({
    this.data,
  });

  List<OtherProductsData>? data;

  factory GetOtherProductsResponse.fromRawJson(String str) => GetOtherProductsResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetOtherProductsResponse.fromJson(Map<String, dynamic> json) => GetOtherProductsResponse(
    data: List<OtherProductsData>.from(json["data"].map((x) => OtherProductsData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class OtherProductsData {
  OtherProductsData({
    this.id,
    this.description,
    this.status,
    this.isSelected = false
  });

  int? id;
  String? description;
  String? status;
  bool isSelected;

  factory OtherProductsData.fromRawJson(String str) => OtherProductsData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OtherProductsData.fromJson(Map<String, dynamic> json) => OtherProductsData(
    id: json["id"],
    description: json["description"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "description": description,
    "status": description,
  };
}
