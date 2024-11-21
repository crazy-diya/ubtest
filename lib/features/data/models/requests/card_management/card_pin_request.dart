// To parse this JSON data, do
//
//     final pinRequest = pinRequestFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

CardPinRequest pinRequestFromJson(String str) => CardPinRequest.fromJson(json.decode(str));

String pinRequestToJson(CardPinRequest data) => json.encode(data.toJson());

class CardPinRequest extends Equatable{
    final String? maskedCardNumber;
    final String? messageType;
    final String? pinChangeReason;

    CardPinRequest({
        this.maskedCardNumber,
        this.messageType,
        this.pinChangeReason,
    });

    factory CardPinRequest.fromJson(Map<String, dynamic> json) => CardPinRequest(
        maskedCardNumber: json["maskedCardNumber"],
        messageType: json["messageType"],
        pinChangeReason: json["pinChangeReason"],
    );

    Map<String, dynamic> toJson() => {
        "maskedCardNumber": maskedCardNumber,
        "messageType": messageType,
        "pinChangeReason": pinChangeReason,
    };
    
      @override
      List<Object?> get props => [maskedCardNumber,messageType,pinChangeReason];
}
