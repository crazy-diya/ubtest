// To parse this JSON data, do
//
//     final cardEStatementRequest = cardEStatementRequestFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

CardEStatementRequest cardEStatementRequestFromJson(String str) => CardEStatementRequest.fromJson(json.decode(str));

String cardEStatementRequestToJson(CardEStatementRequest data) => json.encode(data.toJson());

class CardEStatementRequest extends Equatable{
    final String? maskedPrimaryCardNumber;
    final String? messageType;
    final String? isGreenStatement;

    CardEStatementRequest({
        this.maskedPrimaryCardNumber,
        this.messageType,
        this.isGreenStatement,
    });

    factory CardEStatementRequest.fromJson(Map<String, dynamic> json) => CardEStatementRequest(
        maskedPrimaryCardNumber: json["maskedPrimaryCardNumber"],
        messageType: json["messageType"],
        isGreenStatement: json["isGreenStatement"],
    );

    Map<String, dynamic> toJson() => {
        "maskedPrimaryCardNumber": maskedPrimaryCardNumber,
        "messageType": messageType,
        "isGreenStatement": isGreenStatement,
    };
    
      @override
      List<Object?> get props => [maskedPrimaryCardNumber,messageType,isGreenStatement];
}
