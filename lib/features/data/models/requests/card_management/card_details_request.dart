// To parse this JSON data, do
//
//     final cardDetailsRequest = cardDetailsRequestFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

CardDetailsRequest cardDetailsRequestFromJson(String str) => CardDetailsRequest.fromJson(json.decode(str));

String cardDetailsRequestToJson(CardDetailsRequest data) => json.encode(data.toJson());

class CardDetailsRequest  extends Equatable{
    final String? maskedPrimaryCardNumber;
    final String? messageType;

    CardDetailsRequest({
        this.maskedPrimaryCardNumber,
        this.messageType,
    });

    factory CardDetailsRequest.fromJson(Map<String, dynamic> json) => CardDetailsRequest(
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
