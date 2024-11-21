// To parse this JSON data, do
//
//     final cardLoyaltyRedeemResponse = cardLoyaltyRedeemResponseFromJson(jsonString);

import 'dart:convert';

import '../../../common/base_response.dart';

CardLoyaltyRedeemResponse cardLoyaltyRedeemResponseFromJson(String str) => CardLoyaltyRedeemResponse.fromJson(json.decode(str));

String cardLoyaltyRedeemResponseToJson(CardLoyaltyRedeemResponse data) => json.encode(data.toJson());

class CardLoyaltyRedeemResponse extends Serializable{
  String? resMaskedCardNumber;
  String? resLocalTxnDtTime;
  String? resErrCode;
  String? resErrMsg;
  String? resHdrTranId;
  String? resCifNumber;
  String? resTxnRefCode;
  String? resTxnRefNo;
  String? resCmsAccNo;
  String? resPointsRedeemed;
  String? resOpeningBalance;
  String? resClosingBalance;

  CardLoyaltyRedeemResponse({
    this.resMaskedCardNumber,
    this.resLocalTxnDtTime,
    this.resErrCode,
    this.resErrMsg,
    this.resHdrTranId,
    this.resCifNumber,
    this.resTxnRefCode,
    this.resTxnRefNo,
    this.resCmsAccNo,
    this.resPointsRedeemed,
    this.resOpeningBalance,
    this.resClosingBalance,
  });

  factory CardLoyaltyRedeemResponse.fromJson(Map<String, dynamic> json) => CardLoyaltyRedeemResponse(
    resMaskedCardNumber: json["resMaskedCardNumber"],
    resLocalTxnDtTime: json["resLocalTxnDtTime"],
    resErrCode: json["resErrCode"],
    resErrMsg: json["resErrMsg"],
    resHdrTranId: json["resHdrTranID"],
    resCifNumber: json["resCIFNumber"],
    resTxnRefCode: json["resTxnRefCode"],
    resTxnRefNo: json["resTxnRefNo"],
    resCmsAccNo: json["resCMSAccNo"],
    resPointsRedeemed: json["resPointsRedeemed"],
    resOpeningBalance: json["resOpeningBalance"],
    resClosingBalance: json["resClosingBalance"],
  );

  Map<String, dynamic> toJson() => {
    "resMaskedCardNumber": resMaskedCardNumber,
    "resLocalTxnDtTime": resLocalTxnDtTime,
    "resErrCode": resErrCode,
    "resErrMsg": resErrMsg,
    "resHdrTranID": resHdrTranId,
    "resCIFNumber": resCifNumber,
    "resTxnRefCode": resTxnRefCode,
    "resTxnRefNo": resTxnRefNo,
    "resCMSAccNo": resCmsAccNo,
    "resPointsRedeemed": resPointsRedeemed,
    "resOpeningBalance": resOpeningBalance,
    "resClosingBalance": resClosingBalance,
  };
}
