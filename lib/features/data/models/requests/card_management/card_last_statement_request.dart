// To parse this JSON data, do
//
//     final cardLastStatementRequest = cardLastStatementRequestFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

CardLastStatementRequest cardLastStatementRequestFromJson(String str) => CardLastStatementRequest.fromJson(json.decode(str));

String cardLastStatementRequestToJson(CardLastStatementRequest data) => json.encode(data.toJson());

class CardLastStatementRequest extends Equatable{
    final String? maskedPrimaryCardNumber;
    final String? messageType;

    CardLastStatementRequest({
        this.maskedPrimaryCardNumber,
        this.messageType,
    });

    factory CardLastStatementRequest.fromJson(Map<String, dynamic> json) => CardLastStatementRequest(
        maskedPrimaryCardNumber: json["maskedPrimaryCardNumber"],
        messageType: json["messageType"],
    );

    Map<String, dynamic> toJson() => {
        "maskedPrimaryCardNumber": maskedPrimaryCardNumber,
        "messageType": messageType,
    };
    
      @override
      List<Object?> get props => [maskedPrimaryCardNumber,messageType];
}
