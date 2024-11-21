// To parse this JSON data, do
//
//     final cardPinResponse = cardPinResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

CardPinResponse cardPinResponseFromJson(String str) => CardPinResponse.fromJson(json.decode(str));

String cardPinResponseToJson(CardPinResponse data) => json.encode(data.toJson());

class CardPinResponse extends Serializable{
    final String? resMaskedCardNumber;
    final String? resErrCode;
    final String? resErrMsg;
    final String? resHdrTranId;
    final String? resCmsAccNo;
    final String? resTxnRefNo;
    final String? resCifNumber;
    final String? resTxnRefCode;
    final String? resLocalTxnDtTime;

    CardPinResponse({
        this.resMaskedCardNumber,
        this.resErrCode,
        this.resErrMsg,
        this.resHdrTranId,
        this.resCmsAccNo,
        this.resTxnRefNo,
        this.resCifNumber,
        this.resTxnRefCode,
        this.resLocalTxnDtTime,
    });

    factory CardPinResponse.fromJson(Map<String, dynamic> json) => CardPinResponse(
        resMaskedCardNumber: json["resMaskedCardNumber"],
        resErrCode: json["resErrCode"],
        resErrMsg: json["resErrMsg"],
        resHdrTranId: json["resHdrTranID"],
        resCmsAccNo: json["resCMSAccNo"],
        resTxnRefNo: json["resTxnRefNo"],
        resCifNumber: json["resCIFNumber"],
        resTxnRefCode: json["resTxnRefCode"],
        resLocalTxnDtTime: json["resLocalTxnDtTime"],
    );

    Map<String, dynamic> toJson() => {
        "resMaskedCardNumber": resMaskedCardNumber,
        "resErrCode": resErrCode,
        "resErrMsg": resErrMsg,
        "resHdrTranID": resHdrTranId,
        "resCMSAccNo": resCmsAccNo,
        "resTxnRefNo": resTxnRefNo,
        "resCIFNumber": resCifNumber,
        "resTxnRefCode": resTxnRefCode,
        "resLocalTxnDtTime": resLocalTxnDtTime,
    };
}
