// To parse this JSON data, do
//
//     final getCurrencyListResponse = getCurrencyListResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

GetCurrencyListResponse getCurrencyListResponseFromJson(String str) => GetCurrencyListResponse.fromJson(json.decode(str));

String getCurrencyListResponseToJson(GetCurrencyListResponse data) => json.encode(data.toJson());

class GetCurrencyListResponse extends Serializable{
  List<CurrencyResponse>? data;

  GetCurrencyListResponse({
    this.data,
  });

  factory GetCurrencyListResponse.fromJson(Map<String, dynamic> json) => GetCurrencyListResponse(
    data: json["data"] != null ? List<CurrencyResponse>.from(json["data"].map((x) => CurrencyResponse.fromJson(x))) : [],
  );

  Map<String, dynamic> toJson() => {
    "data":data == null? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class CurrencyResponse {
  String? currencyCode;
  String? currencyDescription;
  String? status;

  CurrencyResponse({
    this.currencyCode,
    this.currencyDescription,
    this.status,
  });

  factory CurrencyResponse.fromJson(Map<String, dynamic> json) => CurrencyResponse(
    currencyCode: json["currencyCode"],
    currencyDescription: json["currencyDescription"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "currencyCode": currencyCode,
    "currencyDescription": currencyDescription,
    "status": status,
  };
}
