// To parse this JSON data, do
//
//     final getTxnCategoryResponse = getTxnCategoryResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

GetTxnCategoryResponse getTxnCategoryResponseFromJson(String str) => GetTxnCategoryResponse.fromJson(json.decode(str));

String getTxnCategoryResponseToJson(GetTxnCategoryResponse data) => json.encode(data.toJson());

class GetTxnCategoryResponse extends Serializable{
  List<FtTxnCategoryResponseDto>? ftTxnCategoryResponseDtos;

  GetTxnCategoryResponse({
    this.ftTxnCategoryResponseDtos,
  });

  factory GetTxnCategoryResponse.fromJson(Map<String, dynamic> json) => GetTxnCategoryResponse(
    ftTxnCategoryResponseDtos: List<FtTxnCategoryResponseDto>.from(json["ftTxnCategoryResponseDTOS"].map((x) => FtTxnCategoryResponseDto.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ftTxnCategoryResponseDTOS": List<dynamic>.from(ftTxnCategoryResponseDtos!.map((x) => x.toJson())),
  };
}

class FtTxnCategoryResponseDto {
  String? category;
  int? id;

  FtTxnCategoryResponseDto({
    this.category,
    this.id,
  });

  factory FtTxnCategoryResponseDto.fromJson(Map<String, dynamic> json) => FtTxnCategoryResponseDto(
    category: json["category"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "category": category,
    "id": id,
  };
}
