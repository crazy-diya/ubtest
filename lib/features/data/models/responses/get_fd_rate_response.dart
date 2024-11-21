// // To parse this JSON data, do
// //
// //     final getFdRateResponse = getFdRateResponseFromJson(jsonString);
//
// import 'dart:convert';
//
// import 'package:union_bank_mobile/features/data/models/common/base_response.dart';
//
// GetFdRateResponse getFdRateResponseFromJson(String str) => GetFdRateResponse.fromJson(json.decode(str));
//
// String getFdRateResponseToJson(GetFdRateResponse data) => json.encode(data.toJson());
//
// class GetFdRateResponse extends Serializable{
//   final String? rate;
//
//   GetFdRateResponse({
//     this.rate,
//   });
//
//   factory GetFdRateResponse.fromJson(Map<String, dynamic> json) => GetFdRateResponse(
//     rate: json["rate"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "rate": rate,
//   };
// }
// To parse this JSON data, do
//
//     final getFdRateResponse = getFdRateResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

GetFdRateResponse getFdRateResponseFromJson(String str) => GetFdRateResponse.fromJson(json.decode(str));

String getFdRateResponseToJson(GetFdRateResponse data) => json.encode(data.toJson());

class GetFdRateResponse extends Serializable{
  final List<FdRatesCbsResponseDtoList>? fdRatesCbsResponseDtoList;

  GetFdRateResponse({
    this.fdRatesCbsResponseDtoList,
  });

  factory GetFdRateResponse.fromJson(Map<String, dynamic> json) => GetFdRateResponse(
    fdRatesCbsResponseDtoList: json["fdRatesCbsResponseDTOList"] == null ? [] : List<FdRatesCbsResponseDtoList>.from(json["fdRatesCbsResponseDTOList"]!.map((x) => FdRatesCbsResponseDtoList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "fdRatesCbsResponseDTOList": fdRatesCbsResponseDtoList == null ? [] : List<dynamic>.from(fdRatesCbsResponseDtoList!.map((x) => x.toJson())),
  };
}

class FdRatesCbsResponseDtoList {
  final String? code;
  final String? description;
  final String? currency;
  final String? rate;
  final String? type;
  final String? count;

  FdRatesCbsResponseDtoList({
    this.code,
    this.description,
    this.currency,
    this.rate,
    this.type,
    this.count,
  });

  factory FdRatesCbsResponseDtoList.fromJson(Map<String, dynamic> json) => FdRatesCbsResponseDtoList(
    code: json["code"],
    description: json["description"],
    currency: json["currency"],
    rate: json["rate"],
    type: json["type"],
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "description": description,
    "currency": currency,
    "rate": rate,
    "type": type,
    "count": count,
  };
}
