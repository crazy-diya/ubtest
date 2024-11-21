// To parse this JSON data, do
//
//     final cardCreditLimitRequest = cardCreditLimitRequestFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

CardCreditLimitRequest cardCreditLimitRequestFromJson(String str) => CardCreditLimitRequest.fromJson(json.decode(str));

String cardCreditLimitRequestToJson(CardCreditLimitRequest data) => json.encode(data.toJson());

class CardCreditLimitRequest extends Equatable{
    final String? maskedAddonCardNumber;
    final String? messageType;
    final String? addonCrLimitPerc;
    final String? addonCashLimitPerc;

    CardCreditLimitRequest({
        this.maskedAddonCardNumber,
        this.messageType,
        this.addonCrLimitPerc,
        this.addonCashLimitPerc,
    });

    factory CardCreditLimitRequest.fromJson(Map<String, dynamic> json) => CardCreditLimitRequest(
        maskedAddonCardNumber: json["maskedAddonCardNumber"],
        messageType: json["messageType"],
        addonCrLimitPerc: json["addonCrLimitPerc"],
        addonCashLimitPerc: json["addonCashLimitPerc"],
    );

    Map<String, dynamic> toJson() => {
        "maskedAddonCardNumber": maskedAddonCardNumber,
        "messageType": messageType,
        "addonCrLimitPerc": addonCrLimitPerc,
        "addonCashLimitPerc": addonCashLimitPerc,
    };
    
      @override
      List<Object?> get props => [maskedAddonCardNumber,messageType,addonCrLimitPerc,addonCashLimitPerc];
}
