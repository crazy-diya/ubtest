// To parse this JSON data, do
//
//     final cardActivationRequest = cardActivationRequestFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

CardActivationRequest cardActivationRequestFromJson(String str) => CardActivationRequest.fromJson(json.decode(str));

String cardActivationRequestToJson(CardActivationRequest data) => json.encode(data.toJson());

class CardActivationRequest extends Equatable{
    final String? maskedCardNumber;
    final String? messageType;

    CardActivationRequest({
        this.maskedCardNumber,
        this.messageType,
    });

    factory CardActivationRequest.fromJson(Map<String, dynamic> json) => CardActivationRequest(
        maskedCardNumber: json["maskedCardNumber"],
        messageType: json["messageType"],
    );

    Map<String, dynamic> toJson() => {
        "maskedCardNumber": maskedCardNumber,
        "messageType": messageType,
    };
    
      @override
      List<Object?> get props => [maskedCardNumber,messageType];
}
