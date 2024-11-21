// To parse this JSON data, do
//
//     final cardEStatementResponse = cardEStatementResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

CardEStatementResponse cardEStatementResponseFromJson(String str) => CardEStatementResponse.fromJson(json.decode(str));

String cardEStatementResponseToJson(CardEStatementResponse data) => json.encode(data.toJson());

class CardEStatementResponse extends Serializable{
    CardEStatementResponse();

    factory CardEStatementResponse.fromJson(Map<String, dynamic> json) => CardEStatementResponse(
    );

    Map<String, dynamic> toJson() => {
    };
}
