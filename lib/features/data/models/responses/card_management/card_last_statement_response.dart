// To parse this JSON data, do
//
//     final cardLastStatementResponse = cardLastStatementResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

CardLastStatementResponse cardLastStatementResponseFromJson(String str) => CardLastStatementResponse.fromJson(json.decode(str));

String cardLastStatementResponseToJson(CardLastStatementResponse data) => json.encode(data.toJson());

class CardLastStatementResponse extends Serializable{
    final String? resLoyBonusPoints;
    final String? resLoyPointsPurchased;
    final String? resAvailCashLimit;
    final String? resOpeningBalance;
    final String? resLoyPtsOpeningBal;
    final DateTime? resStmtToPeriod;
    final String? resClosingBalance;
    final String? resCashAdvances;
    final String? resLoyAvailablePoints;
    final String? resMonthlyIntRatePurchase;
    final String? resCreditLimit;
    final DateTime? resStmtFromPeriod;
    final String? resMonthlyIntRateCash;
    final List<dynamic>? addonTxnDetails;
    final String? resPreviousBalance;
    final List<PrimaryTxnDetail>? primaryTxnDetails;
    final String? resMaskedPrimaryCardNumber;
    final String? resAvailCrLimit;
    final String? resPastDue;
    final String? resTotMinAmt;
    final String? resPurchases;
    final String? resPayments;
    final String? resCredits;
    final String? resTotalAmt;
    final String? resMinAmtDue;
    final String? resCharges;
    final String? resLocalTxnDtTime;
    final String? resHdrTranId;
    final String? resCifNumber;
    final String? resTxnRefNo;
    final String? resTxnRefCode;
    final String? resErrMsg;
    final String? resErrCode;
    final String? resCmsAccNo;

    CardLastStatementResponse({
        this.resLoyBonusPoints,
        this.resLoyPointsPurchased,
        this.resAvailCashLimit,
        this.resOpeningBalance,
        this.resLoyPtsOpeningBal,
        this.resStmtToPeriod,
        this.resClosingBalance,
        this.resCashAdvances,
        this.resLoyAvailablePoints,
        this.resMonthlyIntRatePurchase,
        this.resCreditLimit,
        this.resStmtFromPeriod,
        this.resMonthlyIntRateCash,
        this.addonTxnDetails,
        this.resPreviousBalance,
        this.primaryTxnDetails,
        this.resMaskedPrimaryCardNumber,
        this.resAvailCrLimit,
        this.resPastDue,
        this.resTotMinAmt,
        this.resPurchases,
        this.resPayments,
        this.resCredits,
        this.resTotalAmt,
        this.resMinAmtDue,
        this.resCharges,
        this.resLocalTxnDtTime,
        this.resHdrTranId,
        this.resCifNumber,
        this.resTxnRefNo,
        this.resTxnRefCode,
        this.resErrMsg,
        this.resErrCode,
        this.resCmsAccNo,
    });

    factory CardLastStatementResponse.fromJson(Map<String, dynamic> json) => CardLastStatementResponse(
        resLoyBonusPoints: json["resLoyBonusPoints"],
        resLoyPointsPurchased: json["resLoyPointsPurchased"],
        resAvailCashLimit: json["resAvailCashLimit"],
        resOpeningBalance: json["resOpeningBalance"],
        resLoyPtsOpeningBal: json["resLoyPtsOpeningBal"],
        resStmtToPeriod: json["resStmtToPeriod"] == null ? null : DateTime.parse(json["resStmtToPeriod"]),
        resClosingBalance: json["resClosingBalance"],
        resCashAdvances: json["resCashAdvances"],
        resLoyAvailablePoints: json["resLoyAvailablePoints"],
        resMonthlyIntRatePurchase: json["resMonthlyIntRatePurchase"],
        resCreditLimit: json["resCreditLimit"],
        resStmtFromPeriod: json["resStmtFromPeriod"] == null ? null : DateTime.parse(json["resStmtFromPeriod"]),
        resMonthlyIntRateCash: json["resMonthlyIntRateCash"],
        addonTxnDetails: json["addonTxnDetails"] == null ? [] : List<dynamic>.from(json["addonTxnDetails"]!.map((x) => x)),
        resPreviousBalance: json["resPreviousBalance"],
        primaryTxnDetails: json["primaryTxnDetails"] == null ? [] : List<PrimaryTxnDetail>.from(json["primaryTxnDetails"]!.map((x) => PrimaryTxnDetail.fromJson(x))),
        resMaskedPrimaryCardNumber: json["resMaskedPrimaryCardNumber"],
        resAvailCrLimit: json["resAvailCrLimit"],
        resPastDue: json["resPastDue"],
        resTotMinAmt: json["resTotMinAmt"],
        resPurchases: json["resPurchases"],
        resPayments: json["resPayments"],
        resCredits: json["resCredits"],
        resTotalAmt: json["resTotalAmt"],
        resMinAmtDue: json["resMinAmtDue"],
        resCharges: json["resCharges"],
        resLocalTxnDtTime: json["resLocalTxnDtTime"],
        resHdrTranId: json["resHdrTranID"],
        resCifNumber: json["resCIFNumber"],
        resTxnRefNo: json["resTxnRefNo"],
        resTxnRefCode: json["resTxnRefCode"],
        resErrMsg: json["resErrMsg"],
        resErrCode: json["resErrCode"],
        resCmsAccNo: json["resCMSAccNo"],
    );

    Map<String, dynamic> toJson() => {
        "resLoyBonusPoints": resLoyBonusPoints,
        "resLoyPointsPurchased": resLoyPointsPurchased,
        "resAvailCashLimit": resAvailCashLimit,
        "resOpeningBalance": resOpeningBalance,
        "resLoyPtsOpeningBal": resLoyPtsOpeningBal,
        "resStmtToPeriod": resStmtToPeriod?.toIso8601String(),
        "resClosingBalance": resClosingBalance,
        "resCashAdvances": resCashAdvances,
        "resLoyAvailablePoints": resLoyAvailablePoints,
        "resMonthlyIntRatePurchase": resMonthlyIntRatePurchase,
        "resCreditLimit": resCreditLimit,
        "resStmtFromPeriod": resStmtFromPeriod?.toIso8601String(),
        "resMonthlyIntRateCash": resMonthlyIntRateCash,
        "addonTxnDetails": addonTxnDetails == null ? [] : List<dynamic>.from(addonTxnDetails!.map((x) => x)),
        "resPreviousBalance": resPreviousBalance,
        "primaryTxnDetails": primaryTxnDetails == null ? [] : List<dynamic>.from(primaryTxnDetails!.map((x) => x.toJson())),
        "resMaskedPrimaryCardNumber": resMaskedPrimaryCardNumber,
        "resAvailCrLimit": resAvailCrLimit,
        "resPastDue": resPastDue,
        "resTotMinAmt": resTotMinAmt,
        "resPurchases": resPurchases,
        "resPayments": resPayments,
        "resCredits": resCredits,
        "resTotalAmt": resTotalAmt,
        "resMinAmtDue": resMinAmtDue,
        "resCharges": resCharges,
        "resLocalTxnDtTime": resLocalTxnDtTime,
        "resHdrTranID": resHdrTranId,
        "resCIFNumber": resCifNumber,
        "resTxnRefNo": resTxnRefNo,
        "resTxnRefCode": resTxnRefCode,
        "resErrMsg": resErrMsg,
        "resErrCode": resErrCode,
        "resCMSAccNo": resCmsAccNo,
    };
}

class PrimaryTxnDetail {
    final String? resTransactedMaksedCardNum;
    final String? resTxnCurrency;
    final DateTime? resTransPostDate;
    final String? resDebitsCreditIndicator;
    final String? resRefNo;
    final String? resTransDesc;
    final String? resAmtInLkr;
    final String? resTxnAmount;

    PrimaryTxnDetail({
        this.resTransactedMaksedCardNum,
        this.resTxnCurrency,
        this.resTransPostDate,
        this.resDebitsCreditIndicator,
        this.resRefNo,
        this.resTransDesc,
        this.resAmtInLkr,
        this.resTxnAmount,
    });

    factory PrimaryTxnDetail.fromJson(Map<String, dynamic> json) => PrimaryTxnDetail(
        resTransactedMaksedCardNum: json["resTransactedMaksedCardNum"],
        resTxnCurrency: json["resTxnCurrency"],
        resTransPostDate: json["resTransPostDate"] == null ? null : DateTime.parse(json["resTransPostDate"]),
        resDebitsCreditIndicator: json["resDebitsCreditIndicator"],
        resRefNo: json["resRefNo"],
        resTransDesc: json["resTransDesc"],
        resAmtInLkr: json["resAmtInLKR"],
        resTxnAmount: json["resTxnAmount"],
    );

    Map<String, dynamic> toJson() => {
        "resTransactedMaksedCardNum": resTransactedMaksedCardNum,
        "resTxnCurrency": resTxnCurrency,
        "resTransPostDate": resTransPostDate?.toIso8601String(),
        "resDebitsCreditIndicator": resDebitsCreditIndicator,
        "resRefNo": resRefNo,
        "resTransDesc": resTransDesc,
        "resAmtInLKR": resAmtInLkr,
        "resTxnAmount": resTxnAmount,
    };
}
