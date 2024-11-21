// To parse this JSON data, do
//
//     final cardLostStolenRequest = cardLostStolenRequestFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

CardLostStolenRequest cardLostStolenRequestFromJson(String str) => CardLostStolenRequest.fromJson(json.decode(str));

String cardLostStolenRequestToJson(CardLostStolenRequest data) => json.encode(data.toJson());

class CardLostStolenRequest extends Equatable{
    final String? maskedCardNumber;
    final String? messageType;
    final String? reissueRequest;
    final String? branchCode;
    final bool? isBranch;

    CardLostStolenRequest({
        this.maskedCardNumber,
        this.messageType,
        this.reissueRequest,
        this.branchCode,
        this.isBranch,
    });

    factory CardLostStolenRequest.fromJson(Map<String, dynamic> json) => CardLostStolenRequest(
        maskedCardNumber: json["maskedCardNumber"],
        messageType: json["messageType"],
        reissueRequest: json["reissueRequest"],
        branchCode: json["branchCode"],
        isBranch: json["isBranch"],
    );

    Map<String, dynamic> toJson() => {
        "maskedCardNumber": maskedCardNumber,
        "messageType": messageType,
        "reissueRequest": reissueRequest,
        "branchCode": branchCode,
        "isBranch": isBranch,
    };
    
      @override
      List<Object?> get props => [maskedCardNumber,messageType,reissueRequest,branchCode,isBranch];
}
