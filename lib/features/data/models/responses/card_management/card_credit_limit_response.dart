// To parse this JSON data, do
//
//     final cardCreditLimitResponse = cardCreditLimitResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

CardCreditLimitResponse cardCreditLimitResponseFromJson(String str) => CardCreditLimitResponse.fromJson(json.decode(str));

String cardCreditLimitResponseToJson(CardCreditLimitResponse data) => json.encode(data.toJson());

class CardCreditLimitResponse extends Serializable{
    final String? resMaskedAddonCardNumber;
    final String? resAddonCashLimitPerc;
    final String? resAddonCrLimitPerc;
    final String? resHdrTranId;
    final String? resCifNumber;
    final String? resCmsAccNo;
    final String? resTxnRefNo;
    final String? resErrCode;
    final String? resErrMsg;
    final String? resTxnRefCode;
    final String? resLocalTxnDtTime;

    CardCreditLimitResponse({
        this.resMaskedAddonCardNumber,
        this.resAddonCashLimitPerc,
        this.resAddonCrLimitPerc,
        this.resHdrTranId,
        this.resCifNumber,
        this.resCmsAccNo,
        this.resTxnRefNo,
        this.resErrCode,
        this.resErrMsg,
        this.resTxnRefCode,
        this.resLocalTxnDtTime,
    });

    factory CardCreditLimitResponse.fromJson(Map<String, dynamic> json) => CardCreditLimitResponse(
        resMaskedAddonCardNumber: json["resMaskedAddonCardNumber"],
        resAddonCashLimitPerc: json["resAddonCashLimitPerc"],
        resAddonCrLimitPerc: json["resAddonCrLimitPerc"],
        resHdrTranId: json["resHdrTranID"],
        resCifNumber: json["resCIFNumber"],
        resCmsAccNo: json["resCMSAccNo"],
        resTxnRefNo: json["resTxnRefNo"],
        resErrCode: json["resErrCode"],
        resErrMsg: json["resErrMsg"],
        resTxnRefCode: json["resTxnRefCode"],
        resLocalTxnDtTime: json["resLocalTxnDtTime"],
    );

    Map<String, dynamic> toJson() => {
        "resMaskedAddonCardNumber": resMaskedAddonCardNumber,
        "resAddonCashLimitPerc": resAddonCashLimitPerc,
        "resAddonCrLimitPerc": resAddonCrLimitPerc,
        "resHdrTranID": resHdrTranId,
        "resCIFNumber": resCifNumber,
        "resCMSAccNo": resCmsAccNo,
        "resTxnRefNo": resTxnRefNo,
        "resErrCode": resErrCode,
        "resErrMsg": resErrMsg,
        "resTxnRefCode": resTxnRefCode,
        "resLocalTxnDtTime": resLocalTxnDtTime,
    };
}
