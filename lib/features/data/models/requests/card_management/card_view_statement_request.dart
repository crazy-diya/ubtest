// To parse this JSON data, do
//
//     final cardViewStatementRequest = cardViewStatementRequestFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

CardViewStatementRequest cardViewStatementRequestFromJson(String str) => CardViewStatementRequest.fromJson(json.decode(str));

String cardViewStatementRequestToJson(CardViewStatementRequest data) => json.encode(data.toJson());

class CardViewStatementRequest extends Equatable{
    final String? maskedPrimaryCardNumber;
    final String? messageType;
    final String? billMonth;

    CardViewStatementRequest({
        this.maskedPrimaryCardNumber,
        this.messageType,
        this.billMonth,
    });

    factory CardViewStatementRequest.fromJson(Map<String, dynamic> json) => CardViewStatementRequest(
        maskedPrimaryCardNumber: json["maskedPrimaryCardNumber"],
        messageType: json["messageType"],
        billMonth: json["billMonth"],
    );

    Map<String, dynamic> toJson() => {
        "maskedPrimaryCardNumber": maskedPrimaryCardNumber,
        "messageType": messageType,
        "billMonth": billMonth,
    };
    
      @override
      List<Object?> get props => [maskedPrimaryCardNumber,messageType,billMonth];
}
