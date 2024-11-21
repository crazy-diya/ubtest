

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

CardListResponse cardListResponseFromJson(String str) => CardListResponse.fromJson(json.decode(str));

String cardListResponseToJson(CardListResponse data) => json.encode(data.toJson());

class CardListResponse extends Serializable{
    final List<CardResAddonCardDetail>? resAddonCardDetails;
    final List<CardResPrimaryCardDetail>? resPrimaryCardDetails;
    final String? resLocalTxnDtTime;
    final String? resErrCode;
    final String? resCifNumber;
    final String? resHdrTranId;
    final String? resTxnRefCode;
    final String? resTxnRefNo;
    final String? resErrMsg;

    CardListResponse({
        this.resAddonCardDetails,
        this.resPrimaryCardDetails,
        this.resLocalTxnDtTime,
        this.resErrCode,
        this.resCifNumber,
        this.resHdrTranId,
        this.resTxnRefCode,
        this.resTxnRefNo,
        this.resErrMsg,
    });

    factory CardListResponse.fromJson(Map<String, dynamic> json) => CardListResponse(
        resAddonCardDetails: json["resAddonCardDetails"] == null ? [] : List<CardResAddonCardDetail>.from(json["resAddonCardDetails"]!.map((x) => CardResAddonCardDetail.fromJson(x))),
        resPrimaryCardDetails: json["resPrimaryCardDetails"] == null ? [] : List<CardResPrimaryCardDetail>.from(json["resPrimaryCardDetails"]!.map((x) => CardResPrimaryCardDetail.fromJson(x))),
        resLocalTxnDtTime: json["resLocalTxnDtTime"],
        resErrCode: json["resErrCode"],
        resCifNumber: json["resCIFNumber"],
        resHdrTranId: json["resHdrTranID"],
        resTxnRefCode: json["resTxnRefCode"],
        resTxnRefNo: json["resTxnRefNo"],
        resErrMsg: json["resErrMsg"],
    );

    Map<String, dynamic> toJson() => {
        "resAddonCardDetails": resAddonCardDetails == null ? [] : List<dynamic>.from(resAddonCardDetails!.map((x) => x.toJson())),
        "resPrimaryCardDetails": resPrimaryCardDetails == null ? [] : List<dynamic>.from(resPrimaryCardDetails!.map((x) => x.toJson())),
        "resLocalTxnDtTime": resLocalTxnDtTime,
        "resErrCode": resErrCode,
        "resCIFNumber": resCifNumber,
        "resHdrTranID": resHdrTranId,
        "resTxnRefCode": resTxnRefCode,
        "resTxnRefNo": resTxnRefNo,
        "resErrMsg": resErrMsg,
    };
}

class CardResAddonCardDetail {
    final String? resAddonCardTypeWithDesc;
    final String? resAddonMaskedCardNumber;
    final String? resAddonCustomerName;
    final String? resAddonCreditLimit;
    final String? resAddonCardStatusWithDesc;
    final String? resAddonCashLimit;
    final String? resCmsAccNo;
    final String? displayFlag;

    CardResAddonCardDetail({
        this.resAddonCardTypeWithDesc,
        this.resAddonMaskedCardNumber,
        this.resAddonCustomerName,
        this.resAddonCreditLimit,
        this.resAddonCardStatusWithDesc,
        this.resAddonCashLimit,
        this.resCmsAccNo,
        this.displayFlag,
    });

    factory CardResAddonCardDetail.fromJson(Map<String, dynamic> json) => CardResAddonCardDetail(
        resAddonCardTypeWithDesc: json["resAddonCardTypeWithDesc"],
        resAddonMaskedCardNumber: json["resAddonMaskedCardNumber"],
        resAddonCustomerName: json["resAddonCustomerName"],
        resAddonCreditLimit: json["resAddonCreditLimit"],
        resAddonCardStatusWithDesc: json["resAddonCardStatusWithDesc"],
        resAddonCashLimit: json["resAddonCashLimit"],
        resCmsAccNo: json["resCMSAccNo"],
        displayFlag: json["displayFlag"],
    );

    Map<String, dynamic> toJson() => {
        "resAddonCardTypeWithDesc": resAddonCardTypeWithDesc,
        "resAddonMaskedCardNumber": resAddonMaskedCardNumber,
        "resAddonCustomerName": resAddonCustomerName,
        "resAddonCreditLimit": resAddonCreditLimit,
        "resAddonCardStatusWithDesc": resAddonCardStatusWithDesc,
        "resAddonCashLimit": resAddonCashLimit,
        "resCMSAccNo": resCmsAccNo,
        "displayFlag": displayFlag,
    };
}

class CardResPrimaryCardDetail {
    final String? resAvailableBalance;
    final String? resCreditLimit;
    final String? resCardTypeWithDesc;
    final String? resCardStatusWithDesc;
    final String? resPymtDueDate;
    final String? resMaskedPrimaryCardNumber;
    final String? resCardCustName;
    final String? resCurrentOutstandingBalance;
    final String? resCmsAccNo;
    final String? resCashLimit;
    final String? resMinAmtDue;
    final String? displayFlag;
    final String? cfcurr;
    final List<CardResLast5Txn>? resLast5Txns;

    CardResPrimaryCardDetail({
        this.resAvailableBalance,
        this.resCreditLimit,
        this.resCardTypeWithDesc,
        this.resCardStatusWithDesc,
        this.resPymtDueDate,
        this.resMaskedPrimaryCardNumber,
        this.resCardCustName,
        this.resCurrentOutstandingBalance,
        this.resCmsAccNo,
        this.resCashLimit,
        this.resMinAmtDue,
        this.resLast5Txns,
        this.cfcurr,
        this.displayFlag,
    });

    factory CardResPrimaryCardDetail.fromJson(Map<String, dynamic> json) => CardResPrimaryCardDetail(
        resAvailableBalance: json["resAvailableBalance"],
        resCreditLimit: json["resCreditLimit"],
        resCardTypeWithDesc: json["resCardTypeWithDesc"],
        resCardStatusWithDesc: json["resCardStatusWithDesc"],
        resPymtDueDate: json["resPymtDueDate"],
        resMaskedPrimaryCardNumber: json["resMaskedPrimaryCardNumber"],
        resCardCustName: json["resCardCustName"],
        resCurrentOutstandingBalance: json["resCurrentOutstandingBalance"],
        resCmsAccNo: json["resCMSAccNo"],
        resCashLimit: json["resCashLimit"],
        resMinAmtDue: json["resMinAmtDue"],
        displayFlag: json["displayFlag"],
        cfcurr: json["cfcurr"].toString().trim(),
        resLast5Txns: json["resLast5Txns"] == null ? [] : List<CardResLast5Txn>.from(json["resLast5Txns"]!.map((x) => CardResLast5Txn.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "resAvailableBalance": resAvailableBalance,
        "resCreditLimit": resCreditLimit,
        "resCardTypeWithDesc": resCardTypeWithDesc,
        "resCardStatusWithDesc": resCardStatusWithDesc,
        "resPymtDueDate": resPymtDueDate,
        "resMaskedPrimaryCardNumber": resMaskedPrimaryCardNumber,
        "resCardCustName": resCardCustName,
        "resCurrentOutstandingBalance": resCurrentOutstandingBalance,
        "resCMSAccNo": resCmsAccNo,
        "resCashLimit": resCashLimit,
        "resMinAmtDue": resMinAmtDue,
        "displayFlag": displayFlag,
        "cfcurr": cfcurr,
        "resLast5Txns": resLast5Txns == null ? [] : List<dynamic>.from(resLast5Txns!.map((x) => x.toJson())),
    };
}

class CardResLast5Txn {
    final String? resDebitCreditIndicator;
    final String? resRefNo;
    final String? resTransDate;
    final String? resAmount;
    final String? resTransDesc;
    final String? resTxnCardNum;

    CardResLast5Txn({
        this.resDebitCreditIndicator,
        this.resRefNo,
        this.resTransDate,
        this.resAmount,
        this.resTransDesc,
        this.resTxnCardNum,
    });

    factory CardResLast5Txn.fromJson(Map<String, dynamic> json) => CardResLast5Txn(
        resDebitCreditIndicator: json["resDebitCreditIndicator"],
        resRefNo: json["resRefNo"],
        resTransDate: json["resTransDate"],
        resAmount: json["resAmount"],
        resTransDesc: json["resTransDesc"],
        resTxnCardNum: json["resTxnCardNum"],
    );

    Map<String, dynamic> toJson() => {
        "resDebitCreditIndicator": resDebitCreditIndicator,
        "resRefNo": resRefNo,
        "resTransDate": resTransDate,
        "resAmount": resAmount,
        "resTransDesc": resTransDesc,
        "resTxnCardNum": resTxnCardNum,
    };
}

