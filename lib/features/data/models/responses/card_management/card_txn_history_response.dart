// To parse this JSON data, do
//
//     final cardTxnHistoryResponse = cardTxnHistoryResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

CardTxnHistoryResponse cardTxnHistoryResponseFromJson(String str) => CardTxnHistoryResponse.fromJson(json.decode(str));

String cardTxnHistoryResponseToJson(CardTxnHistoryResponse data) => json.encode(data.toJson());

class CardTxnHistoryResponse extends Serializable{
    final int? noOfTransactions;
    final String? resMaskedCardNumber;
    final List<TxnDetail>? txnDetails;
    final String? resHdrTranId;
    final String? resTxnRefCode;
    final String? resCifNumber;
    final String? resCmsAccNo;
    final String? resErrCode;
    final String? resLocalTxnDtTime;
    final String? resTxnRefNo;
    final String? resErrMsg;
    final num? totalDebit;
    final num? totalCredit;

    CardTxnHistoryResponse({
        this.noOfTransactions,
        this.resMaskedCardNumber,
        this.txnDetails,
        this.resHdrTranId,
        this.resTxnRefCode,
        this.resCifNumber,
        this.resCmsAccNo,
        this.resErrCode,
        this.resLocalTxnDtTime,
        this.resTxnRefNo,
        this.resErrMsg,
        this.totalDebit,
        this.totalCredit,
    });

    factory CardTxnHistoryResponse.fromJson(Map<String, dynamic> json) => CardTxnHistoryResponse(
        noOfTransactions: json["noOfTransactions"],
        resMaskedCardNumber: json["resMaskedCardNumber"],
        txnDetails: json["txnDetails"] == null ? [] : List<TxnDetail>.from(json["txnDetails"]!.map((x) => TxnDetail.fromJson(x))),
        resHdrTranId: json["resHdrTranID"],
        resTxnRefCode: json["resTxnRefCode"],
        resCifNumber: json["resCIFNumber"],
        resCmsAccNo: json["resCMSAccNo"],
        resErrCode: json["resErrCode"],
        resLocalTxnDtTime: json["resLocalTxnDtTime"],
        resTxnRefNo: json["resTxnRefNo"],
        resErrMsg: json["resErrMsg"],
        totalDebit: json["totalDebit"],
        totalCredit: json["totalCredit"],
    );

    Map<String, dynamic> toJson() => {
        "noOfTransactions": noOfTransactions,
        "resMaskedCardNumber": resMaskedCardNumber,
        "txnDetails": txnDetails == null ? [] : List<dynamic>.from(txnDetails!.map((x) => x.toJson())),
        "resHdrTranID": resHdrTranId,
        "resTxnRefCode": resTxnRefCode,
        "resCIFNumber": resCifNumber,
        "resCMSAccNo": resCmsAccNo,
        "resErrCode": resErrCode,
        "resLocalTxnDtTime": resLocalTxnDtTime,
        "resTxnRefNo": resTxnRefNo,
        "resErrMsg": resErrMsg,
        "totalDebit": totalDebit,
        "totalCredit": totalCredit,
    };
}

class TxnDetail {
    final String? resLocalTxnAmount;
    final String? resDebitCreditIndicator;
    final String? resTxnStatus;
    final String? resLocalTxnCcy;
    final DateTime? resTransDate;
    final String? resRefNo;
    final String? resOrgTxnAmt;
    final String? resAmount;
    final String? resTransDesc;
    final String? resOrgTxnCcy;
    final String? resMaskedCardNum;

    TxnDetail({
        this.resLocalTxnAmount,
        this.resDebitCreditIndicator,
        this.resTxnStatus,
        this.resLocalTxnCcy,
        this.resTransDate,
        this.resRefNo,
        this.resOrgTxnAmt,
        this.resAmount,
        this.resTransDesc,
        this.resOrgTxnCcy,
        this.resMaskedCardNum,
    });

    factory TxnDetail.fromJson(Map<String, dynamic> json) => TxnDetail(
        resLocalTxnAmount: json["resLocalTxnAmount"],
        resDebitCreditIndicator: json["resDebitCreditIndicator"],
        resTxnStatus: json["resTxnStatus"],
        resLocalTxnCcy: json["resLocalTxnCcy"],
        resTransDate: json["resTransDate"]== null ? null : DateTime.parse(json["resTransDate"]),
        resRefNo: json["resRefNo"],
        resOrgTxnAmt: json["resOrgTxnAmt"],
        resAmount: json["resAmount"],
        resTransDesc: json["resTransDesc"],
        resOrgTxnCcy: json["resOrgTxnCcy"],
        resMaskedCardNum: json["resMaskedCardNum"],
    );

    Map<String, dynamic> toJson() => {
        "resLocalTxnAmount": resLocalTxnAmount,
        "resDebitCreditIndicator": resDebitCreditIndicator,
        "resTxnStatus": resTxnStatus,
        "resLocalTxnCcy": resLocalTxnCcy,
        "resTransDate": resTransDate?.toIso8601String(),
        "resRefNo": resRefNo,
        "resOrgTxnAmt": resOrgTxnAmt,
        "resAmount": resAmount,
        "resTransDesc": resTransDesc,
        "resOrgTxnCcy": resOrgTxnCcy,
        "resMaskedCardNum": resMaskedCardNum,
    };
}
