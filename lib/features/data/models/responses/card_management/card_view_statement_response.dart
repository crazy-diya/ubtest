// To parse this JSON data, do
//
//     final cardViewStatementResponse = cardViewStatementResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

CardViewStatementResponse cardViewStatementResponseFromJson(String str) => CardViewStatementResponse.fromJson(json.decode(str));

String cardViewStatementResponseToJson(CardViewStatementResponse data) => json.encode(data.toJson());

class CardViewStatementResponse extends Serializable{
    final String? resMaskedPrimaryCardNumber;
    final String? resLocalTxnDtTime;
    final String? resErrCode;
    final String? resErrMsg;
    final String? resCifNumber;
    final String? resTxnRefCode;
    final String? resCmsAccNo;
    final String? resHdrTranId;
    final String? resTxnRefNo;

    CardViewStatementResponse({
        this.resMaskedPrimaryCardNumber,
        this.resLocalTxnDtTime,
        this.resErrCode,
        this.resErrMsg,
        this.resCifNumber,
        this.resTxnRefCode,
        this.resCmsAccNo,
        this.resHdrTranId,
        this.resTxnRefNo,
    });

    factory CardViewStatementResponse.fromJson(Map<String, dynamic> json) => CardViewStatementResponse(
        resMaskedPrimaryCardNumber: json["resMaskedPrimaryCardNumber"],
        resLocalTxnDtTime: json["resLocalTxnDtTime"],
        resErrCode: json["resErrCode"],
        resErrMsg: json["resErrMsg"],
        resCifNumber: json["resCIFNumber"],
        resTxnRefCode: json["resTxnRefCode"],
        resCmsAccNo: json["resCMSAccNo"],
        resHdrTranId: json["resHdrTranID"],
        resTxnRefNo: json["resTxnRefNo"],
    );

    Map<String, dynamic> toJson() => {
        "resMaskedPrimaryCardNumber": resMaskedPrimaryCardNumber,
        "resLocalTxnDtTime": resLocalTxnDtTime,
        "resErrCode": resErrCode,
        "resErrMsg": resErrMsg,
        "resCIFNumber": resCifNumber,
        "resTxnRefCode": resTxnRefCode,
        "resCMSAccNo": resCmsAccNo,
        "resHdrTranID": resHdrTranId,
        "resTxnRefNo": resTxnRefNo,
    };
}
