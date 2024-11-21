// To parse this JSON data, do
//
//     final chequeBookResponse = chequeBookResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

ChequeBookResponse chequeBookResponseFromJson(String str) => ChequeBookResponse.fromJson(json.decode(str));

String chequeBookResponseToJson(ChequeBookResponse data) => json.encode(data.toJson());

class ChequeBookResponse extends Serializable{
  final int? id;

  ChequeBookResponse({
    this.id,
  });

  factory ChequeBookResponse.fromJson(Map<String, dynamic> json) => ChequeBookResponse(
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
  };
}
