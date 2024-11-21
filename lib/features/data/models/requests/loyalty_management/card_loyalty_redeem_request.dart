// To parse this JSON data, do
//
//     final cardLoyaltyRedeemRequest = cardLoyaltyRedeemRequestFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

CardLoyaltyRedeemRequest cardLoyaltyRedeemRequestFromJson(String str) => CardLoyaltyRedeemRequest.fromJson(json.decode(str));

String cardLoyaltyRedeemRequestToJson(CardLoyaltyRedeemRequest data) => json.encode(data.toJson());

// ignore: must_be_immutable
class CardLoyaltyRedeemRequest extends Equatable{
  String? messageType;
  String? maskedPrimaryCardNumber;
  String? redeemPoints;
  bool? sendToAddressFlag;
  String? collectBranch;
  List<Map<String, int>>? redeemOptions;

  CardLoyaltyRedeemRequest({
    this.messageType,
    this.maskedPrimaryCardNumber,
    this.redeemPoints,
    this.sendToAddressFlag,
    this.collectBranch,
    this.redeemOptions,
  });

  factory CardLoyaltyRedeemRequest.fromJson(Map<String, dynamic> json) => CardLoyaltyRedeemRequest(
    messageType: json["messageType"],
    maskedPrimaryCardNumber: json["maskedPrimaryCardNumber"],
    redeemPoints: json["redeemPoints"],
    sendToAddressFlag: json["sendToAddressFlag"],
    collectBranch: json["collectBranch"],
    redeemOptions: json["redeemOptions"] == null ? [] : List<Map<String, int>>.from(json["redeemOptions"]!.map((x) => Map.from(x).map((k, v) => MapEntry<String, int>(k, v)))),
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "maskedPrimaryCardNumber": maskedPrimaryCardNumber,
    "redeemPoints": redeemPoints,
    "sendToAddressFlag": sendToAddressFlag,
    "collectBranch": collectBranch,
    "redeemOptions": redeemOptions == null ? [] : List<dynamic>.from(redeemOptions!.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
  };

  @override
  List<Object?> get props => [maskedPrimaryCardNumber,messageType,redeemPoints,sendToAddressFlag,collectBranch,redeemOptions];
}
