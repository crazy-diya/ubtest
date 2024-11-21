// To parse this JSON data, do
//
//     final chequeBookResponse = chequeBookResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

SrStatementResponse chequeBookResponseFromJson(String str) => SrStatementResponse.fromJson(json.decode(str));

String chequeBookResponseToJson(SrStatementResponse data) => json.encode(data.toJson());

class SrStatementResponse extends Serializable{
  final int? id;

  SrStatementResponse({
    this.id,
  });

  factory SrStatementResponse.fromJson(Map<String, dynamic> json) => SrStatementResponse(
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
  };
}
