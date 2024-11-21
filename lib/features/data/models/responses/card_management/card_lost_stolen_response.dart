// To parse this JSON data, do
//
//     final cardLostStolenResponse = cardLostStolenResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

CardLostStolenResponse cardLostStolenResponseFromJson(String str) => CardLostStolenResponse.fromJson(json.decode(str));

String cardLostStolenResponseToJson(CardLostStolenResponse data) => json.encode(data.toJson());

class CardLostStolenResponse extends Serializable{
    final String? resMaskedCardNumber;
    final String? resLocalTxnDtTime;
    final String? resErrCode;
    final String? resErrMsg;
    final String? resHdrTranId;
    final String? resCifNumber;
    final String? resTxnRefCode;
    final String? resTxnRefNo;
    final String? resCmsAccNo;

    CardLostStolenResponse({
        this.resMaskedCardNumber,
        this.resLocalTxnDtTime,
        this.resErrCode,
        this.resErrMsg,
        this.resHdrTranId,
        this.resCifNumber,
        this.resTxnRefCode,
        this.resTxnRefNo,
        this.resCmsAccNo,
    });

    factory CardLostStolenResponse.fromJson(Map<String, dynamic> json) => CardLostStolenResponse(
        resMaskedCardNumber: json["resMaskedCardNumber"],
        resLocalTxnDtTime: json["resLocalTxnDtTime"],
        resErrCode: json["resErrCode"],
        resErrMsg: json["resErrMsg"],
        resHdrTranId: json["resHdrTranID"],
        resCifNumber: json["resCIFNumber"],
        resTxnRefCode: json["resTxnRefCode"],
        resTxnRefNo: json["resTxnRefNo"],
        resCmsAccNo: json["resCMSAccNo"],
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
    };
}
