// To parse this JSON data, do
//
//     final getFdPeriodResponse = getFdPeriodResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

GetFdPeriodResponse getFdPeriodResponseFromJson(String str) => GetFdPeriodResponse.fromJson(json.decode(str));

String getFdPeriodResponseToJson(GetFdPeriodResponse data) => json.encode(data.toJson());

class GetFdPeriodResponse extends Serializable{
  List<FDPeriodResponse>? data;

  GetFdPeriodResponse({
    this.data,
  });

  factory GetFdPeriodResponse.fromJson(Map<String, dynamic> json) => GetFdPeriodResponse(
    data: json["data"] != null ? List<FDPeriodResponse>.from(json["data"].map((x) => FDPeriodResponse.fromJson(x))) : [],
  );

  Map<String, dynamic> toJson() => {
    "data": data != null ? List<dynamic>.from(data!.map((x) => x.toJson())) : [],
  };
}

class FDPeriodResponse {
  String? code;
  String? timePeriod;
  String? description;
  String? status;

  FDPeriodResponse({
    this.code,
    this.timePeriod,
    this.description,
    this.status,
  });

  factory FDPeriodResponse.fromJson(Map<String, dynamic> json) => FDPeriodResponse(
    code: json["code"],
    timePeriod: json["timePeriod"],
    description: json["description"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "timePeriod": timePeriod,
    "description": description,
    "status": status,
  };
}
