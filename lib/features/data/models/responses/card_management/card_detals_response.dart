// To parse this JSON data, do
//
//     final cardDetailsResponse = cardDetailsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

// To parse this JSON data, do
//
//     final cardDetailsResponse = cardDetailsResponseFromJson(jsonString);


CardDetailsResponse cardDetailsResponseFromJson(String str) => CardDetailsResponse.fromJson(json.decode(str));

String cardDetailsResponseToJson(CardDetailsResponse data) => json.encode(data.toJson());

class CardDetailsResponse extends Serializable{
    final num? resPendingAuth;
    final String? resPointsEarned;
    final List<ResAddonDetail>? resAddonDetails;
    final String? resLoyaltyAvailablePoints;
    final num? resInstPayableBalance;
    final String? resStatementMode;
    final String? resBilledTotal;
    final String? resPointsToBeExpire;
    final String? resMaskedPrimaryCardNumber;
    final String? resAvailableBalance;
    final DateTime? resStmtPymtDueDate;
    final String? resCardStatusWithDescription;
    final String? resStmtDate;
    final List<TxnDetail>? txnDetails;
    final String? resCardTypeWithDescription;
    final String? resLastPaymentRecivedDate;
    final List<dynamic>? resEmiBalanceDetails;
    final String? resCreditLimit;
    final num? resEmiBalance;
    final String? resAvailableToSpend;
    final String? resCashLimit;
    final String? resPointsExpired;
    final String? resStmtMinAmtDue;
    final String? resPointsRedeemed;
    final String? resCurrentOutstandingBalance;
    final String? resStatmentBalance;
    final String? resLastPaymentRecived;
    final String? resHdrTranId;
    final String? resTxnRefCode;
    final String? resTxnRefNo;
    final String? resCifNumber;
    final String? resCmsAccNo;
    final String? resErrCode;
    final String? resErrMsg;
    final String? resLocalTxnDtTime;

    CardDetailsResponse({
        this.resPendingAuth,
        this.resPointsEarned,
        this.resAddonDetails,
        this.resLoyaltyAvailablePoints,
        this.resInstPayableBalance,
        this.resStatementMode,
        this.resBilledTotal,
        this.resPointsToBeExpire,
        this.resMaskedPrimaryCardNumber,
        this.resAvailableBalance,
        this.resStmtPymtDueDate,
        this.resCardStatusWithDescription,
        this.resStmtDate,
        this.txnDetails,
        this.resCardTypeWithDescription,
        this.resLastPaymentRecivedDate,
        this.resEmiBalanceDetails,
        this.resCreditLimit,
        this.resEmiBalance,
        this.resAvailableToSpend,
        this.resCashLimit,
        this.resPointsExpired,
        this.resStmtMinAmtDue,
        this.resPointsRedeemed,
        this.resCurrentOutstandingBalance,
        this.resStatmentBalance,
        this.resLastPaymentRecived,
        this.resHdrTranId,
        this.resTxnRefCode,
        this.resTxnRefNo,
        this.resCifNumber,
        this.resCmsAccNo,
        this.resErrCode,
        this.resErrMsg,
        this.resLocalTxnDtTime,
    });

    factory CardDetailsResponse.fromJson(Map<String, dynamic> json) => CardDetailsResponse(
        resPendingAuth: json["resPendingAuth"],
        resPointsEarned: json["resPointsEarned"],
        resAddonDetails: json["resAddonDetails"] == null ? [] : List<ResAddonDetail>.from(json["resAddonDetails"]!.map((x) => ResAddonDetail.fromJson(x))),
        resLoyaltyAvailablePoints: json["resLoyaltyAvailablePoints"],
        resInstPayableBalance: json["resInstPayableBalance"],
        resStatementMode: json["resStatementMode"],
        resBilledTotal: json["resBilledTotal"],
        resPointsToBeExpire: json["resPointsToBeExpire"],
        resMaskedPrimaryCardNumber: json["resMaskedPrimaryCardNumber"],
        resAvailableBalance: json["resAvailableBalance"],
        resStmtPymtDueDate: json["resStmtPymtDueDate"] == "" ? null : DateTime.parse(json["resStmtPymtDueDate"]),
        resCardStatusWithDescription: json["resCardStatusWithDescription"],
        resStmtDate: json["resStmtDate"],
        txnDetails: json["txnDetails"] == null ? [] : List<TxnDetail>.from(json["txnDetails"]!.map((x) => TxnDetail.fromJson(x))),
        resCardTypeWithDescription: json["resCardTypeWithDescription"],
        resLastPaymentRecivedDate: json["resLastPaymentRecivedDate"],
        resEmiBalanceDetails: json["resEMIBalanceDetails"] == null ? [] : List<dynamic>.from(json["resEMIBalanceDetails"]!.map((x) => x)),
        resCreditLimit: json["resCreditLimit"],
        resEmiBalance: json["resEmiBalance"],
        resAvailableToSpend: json["resAvailableToSpend"],
        resCashLimit: json["resCashLimit"],
        resPointsExpired: json["resPointsExpired"],
        resStmtMinAmtDue: json["resStmtMinAmtDue"],
        resPointsRedeemed: json["resPointsRedeemed"],
        resCurrentOutstandingBalance: json["resCurrentOutstandingBalance"],
        resStatmentBalance: json["resStatmentBalance"],
        resLastPaymentRecived: json["resLastPaymentRecived"],
        resHdrTranId: json["resHdrTranID"],
        resTxnRefCode: json["resTxnRefCode"],
        resTxnRefNo: json["resTxnRefNo"],
        resCifNumber: json["resCIFNumber"],
        resCmsAccNo: json["resCMSAccNo"],
        resErrCode: json["resErrCode"],
        resErrMsg: json["resErrMsg"],
        resLocalTxnDtTime: json["resLocalTxnDtTime"],
    );

    Map<String, dynamic> toJson() => {
        "resPendingAuth": resPendingAuth,
        "resPointsEarned": resPointsEarned,
        "resAddonDetails": resAddonDetails == null ? [] : List<dynamic>.from(resAddonDetails!.map((x) => x.toJson())),
        "resLoyaltyAvailablePoints": resLoyaltyAvailablePoints,
        "resInstPayableBalance": resInstPayableBalance,
        "resStatementMode": resStatementMode,
        "resBilledTotal": resBilledTotal,
        "resPointsToBeExpire": resPointsToBeExpire,
        "resMaskedPrimaryCardNumber": resMaskedPrimaryCardNumber,
        "resAvailableBalance": resAvailableBalance,
        "resStmtPymtDueDate": resStmtPymtDueDate?.toIso8601String(),
        "resCardStatusWithDescription": resCardStatusWithDescription,
        "resStmtDate": resStmtDate,
        "txnDetails": txnDetails == null ? [] : List<dynamic>.from(txnDetails!.map((x) => x.toJson())),
        "resCardTypeWithDescription": resCardTypeWithDescription,
        "resLastPaymentRecivedDate": resLastPaymentRecivedDate,
        "resEMIBalanceDetails": resEmiBalanceDetails == null ? [] : List<dynamic>.from(resEmiBalanceDetails!.map((x) => x)),
        "resCreditLimit": resCreditLimit,
        "resEmiBalance": resEmiBalance,
        "resAvailableToSpend": resAvailableToSpend,
        "resCashLimit": resCashLimit,
        "resPointsExpired": resPointsExpired,
        "resStmtMinAmtDue": resStmtMinAmtDue,
        "resPointsRedeemed": resPointsRedeemed,
        "resCurrentOutstandingBalance": resCurrentOutstandingBalance,
        "resStatmentBalance": resStatmentBalance,
        "resLastPaymentRecived": resLastPaymentRecived,
        "resHdrTranID": resHdrTranId,
        "resTxnRefCode": resTxnRefCode,
        "resTxnRefNo": resTxnRefNo,
        "resCIFNumber": resCifNumber,
        "resCMSAccNo": resCmsAccNo,
        "resErrCode": resErrCode,
        "resErrMsg": resErrMsg,
        "resLocalTxnDtTime": resLocalTxnDtTime,
    };
}

class ResAddonDetail {
    final String? resAddonMaskedCardNumber;
    final String? resAddonCardStatusWithDesc;
    final String? resAddonCashLimit;
    final String? resAddonCustomerName;
    final String? resAddonCreditLimit;
    final String? resAddonCardType;

    ResAddonDetail({
        this.resAddonMaskedCardNumber,
        this.resAddonCardStatusWithDesc,
        this.resAddonCashLimit,
        this.resAddonCustomerName,
        this.resAddonCreditLimit,
        this.resAddonCardType,
    });

    factory ResAddonDetail.fromJson(Map<String, dynamic> json) => ResAddonDetail(
        resAddonMaskedCardNumber: json["resAddonMaskedCardNumber"],
        resAddonCardStatusWithDesc: json["resAddonCardStatusWithDesc"],
        resAddonCashLimit: json["resAddonCashLimit"],
        resAddonCustomerName: json["resAddonCustomerName"],
        resAddonCreditLimit: json["resAddonCreditLimit"],
        resAddonCardType: json["resAddonCardType"],
    );

    Map<String, dynamic> toJson() => {
        "resAddonMaskedCardNumber": resAddonMaskedCardNumber,
        "resAddonCardStatusWithDesc": resAddonCardStatusWithDesc,
        "resAddonCashLimit": resAddonCashLimit,
        "resAddonCustomerName": resAddonCustomerName,
        "resAddonCreditLimit": resAddonCreditLimit,
        "resAddonCardType": resAddonCardType,
    };
}

class TxnDetail {
    final String? resDebitCreditIndicator;
    final String? resRefNo;
    final String? resTransDate;
    final String? resAmount;
    final String? resTxnCardNum;
    final String? resTransDesc;

    TxnDetail({
        this.resDebitCreditIndicator,
        this.resRefNo,
        this.resTransDate,
        this.resAmount,
        this.resTxnCardNum,
        this.resTransDesc,
    });

    factory TxnDetail.fromJson(Map<String, dynamic> json) => TxnDetail(
        resDebitCreditIndicator: json["resDebitCreditIndicator"],
        resRefNo: json["resRefNo"],
        resTransDate: json["resTransDate"],
        resAmount: json["resAmount"],
        resTxnCardNum: json["resTxnCardNum"],
        resTransDesc: json["resTransDesc"],
    );

    Map<String, dynamic> toJson() => {
        "resDebitCreditIndicator": resDebitCreditIndicator,
        "resRefNo": resRefNo,
        "resTransDate": resTransDate,
        "resAmount": resAmount,
        "resTxnCardNum": resTxnCardNum,
        "resTransDesc": resTransDesc,
    };
}


//
// class CardDetailsResponse extends Serializable{
//     final String? resCmsAccNo;
//     final String? resStmtDate;
//     final List<TxnDetails>? txnDetails;
//     final int? resEmiBalance;
//     final String? resCashLimit;
//     final String? resPointsToBeExpire;
//     final String? resMaskedPrimaryCardNumber;
//     final String? resAvailableBalance;
//     final DateTime? resStmtPymtDueDate;
//     final String? resCardStatusWithDescription;
//     final String? resCardTypeWithDescription;
//     final String? resLastPaymentRecivedDate;
//     final List<dynamic>? resEmiBalanceDetails;
//     final String? resCreditLimit;
//     final int? resPendingAuth;
//     final String? resPointsExpired;
//     final String? resStmtMinAmtDue;
//     final String? resPointsRedeemed;
//     final String? resCurrentOutstandingBalance;
//     final String? resAvailableToSpend;
//     final String? resPointsEarned;
//     final String? resLoyaltyAvailablePoints;
//     final List<ResAddonDetail>? resAddonDetails;
//     final int? resInstPayableBalance;
//     final String? resStatementMode;
//     final String? resBilledTotal;
//     final String? resLastPaymentRecived;
//     final String? resStatmentBalance;
//     final String? resErrCode;
//     final String? resTxnRefNo;
//     final String? resTxnRefCode;
//     final String? resCifNumber;
//     final String? resHdrTranId;
//     final String? resErrMsg;
//     final String? resLocalTxnDtTime;
//
//     CardDetailsResponse({
//         this.resCmsAccNo,
//         this.resStmtDate,
//         this.txnDetails,
//         this.resEmiBalance,
//         this.resCashLimit,
//         this.resPointsToBeExpire,
//         this.resMaskedPrimaryCardNumber,
//         this.resAvailableBalance,
//         this.resStmtPymtDueDate,
//         this.resCardStatusWithDescription,
//         this.resCardTypeWithDescription,
//         this.resLastPaymentRecivedDate,
//         this.resEmiBalanceDetails,
//         this.resCreditLimit,
//         this.resPendingAuth,
//         this.resPointsExpired,
//         this.resStmtMinAmtDue,
//         this.resPointsRedeemed,
//         this.resCurrentOutstandingBalance,
//         this.resAvailableToSpend,
//         this.resPointsEarned,
//         this.resLoyaltyAvailablePoints,
//         this.resAddonDetails,
//         this.resInstPayableBalance,
//         this.resStatementMode,
//         this.resBilledTotal,
//         this.resLastPaymentRecived,
//         this.resStatmentBalance,
//         this.resErrCode,
//         this.resTxnRefNo,
//         this.resTxnRefCode,
//         this.resCifNumber,
//         this.resHdrTranId,
//         this.resErrMsg,
//         this.resLocalTxnDtTime,
//     });
//
//     factory CardDetailsResponse.fromJson(Map<String, dynamic> json) => CardDetailsResponse(
//         resCmsAccNo: json["resCMSAccNo"],
//         resStmtDate: json["resStmtDate"],
//         txnDetails: json["txnDetails"] == null ? [] : List<TxnDetails>.from(json["txnDetails"]!.map((x) => TxnDetails.fromJson(x))),
//         resEmiBalance: json["resEmiBalance"],
//         resCashLimit: json["resCashLimit"],
//         resPointsToBeExpire: json["resPointsToBeExpire"],
//         resMaskedPrimaryCardNumber: json["resMaskedPrimaryCardNumber"],
//         resAvailableBalance: json["resAvailableBalance"],
//         resStmtPymtDueDate: json["resStmtPymtDueDate"] == null ? null : DateTime.parse(json["resStmtPymtDueDate"]),
//         resCardStatusWithDescription: json["resCardStatusWithDescription"],
//         resCardTypeWithDescription: json["resCardTypeWithDescription"],
//         resLastPaymentRecivedDate: json["resLastPaymentRecivedDate"],
//         resEmiBalanceDetails: json["resEMIBalanceDetails"] == null ? [] : List<dynamic>.from(json["resEMIBalanceDetails"]!.map((x) => x)),
//         resCreditLimit: json["resCreditLimit"],
//         resPendingAuth: json["resPendingAuth"],
//         resPointsExpired: json["resPointsExpired"],
//         resStmtMinAmtDue: json["resStmtMinAmtDue"],
//         resPointsRedeemed: json["resPointsRedeemed"],
//         resCurrentOutstandingBalance: json["resCurrentOutstandingBalance"],
//         resAvailableToSpend: json["resAvailableToSpend"],
//         resPointsEarned: json["resPointsEarned"],
//         resLoyaltyAvailablePoints: json["resLoyaltyAvailablePoints"],
//         resAddonDetails: json["resAddonDetails"] == null ? [] : List<ResAddonDetail>.from(json["resAddonDetails"]!.map((x) => ResAddonDetail.fromJson(x))),
//         resInstPayableBalance: json["resInstPayableBalance"],
//         resStatementMode: json["resStatementMode"],
//         resBilledTotal: json["resBilledTotal"],
//         resLastPaymentRecived: json["resLastPaymentRecived"],
//         resStatmentBalance: json["resStatmentBalance"],
//         resErrCode: json["resErrCode"],
//         resTxnRefNo: json["resTxnRefNo"],
//         resTxnRefCode: json["resTxnRefCode"],
//         resCifNumber: json["resCIFNumber"],
//         resHdrTranId: json["resHdrTranID"],
//         resErrMsg: json["resErrMsg"],
//         resLocalTxnDtTime: json["resLocalTxnDtTime"],
//     );
//
//     Map<String, dynamic> toJson() => {
//         "resCMSAccNo": resCmsAccNo,
//         "resStmtDate": resStmtDate,
//         "txnDetails": txnDetails == null ? [] : List<dynamic>.from(txnDetails!.map((x) => x.toJson())),
//         "resEmiBalance": resEmiBalance,
//         "resCashLimit": resCashLimit,
//         "resPointsToBeExpire": resPointsToBeExpire,
//         "resMaskedPrimaryCardNumber": resMaskedPrimaryCardNumber,
//         "resAvailableBalance": resAvailableBalance,
//         "resStmtPymtDueDate": resStmtPymtDueDate?.toIso8601String(),
//         "resCardStatusWithDescription": resCardStatusWithDescription,
//         "resCardTypeWithDescription": resCardTypeWithDescription,
//         "resLastPaymentRecivedDate": resLastPaymentRecivedDate,
//         "resEMIBalanceDetails": resEmiBalanceDetails == null ? [] : List<dynamic>.from(resEmiBalanceDetails!.map((x) => x)),
//         "resCreditLimit": resCreditLimit,
//         "resPendingAuth": resPendingAuth,
//         "resPointsExpired": resPointsExpired,
//         "resStmtMinAmtDue": resStmtMinAmtDue,
//         "resPointsRedeemed": resPointsRedeemed,
//         "resCurrentOutstandingBalance": resCurrentOutstandingBalance,
//         "resAvailableToSpend": resAvailableToSpend,
//         "resPointsEarned": resPointsEarned,
//         "resLoyaltyAvailablePoints": resLoyaltyAvailablePoints,
//         "resAddonDetails": resAddonDetails == null ? [] : List<dynamic>.from(resAddonDetails!.map((x) => x.toJson())),
//         "resInstPayableBalance": resInstPayableBalance,
//         "resStatementMode": resStatementMode,
//         "resBilledTotal": resBilledTotal,
//         "resLastPaymentRecived": resLastPaymentRecived,
//         "resStatmentBalance": resStatmentBalance,
//         "resErrCode": resErrCode,
//         "resTxnRefNo": resTxnRefNo,
//         "resTxnRefCode": resTxnRefCode,
//         "resCIFNumber": resCifNumber,
//         "resHdrTranID": resHdrTranId,
//         "resErrMsg": resErrMsg,
//         "resLocalTxnDtTime": resLocalTxnDtTime,
//     };
// }
//
// class ResAddonDetail {
//     final String? resAddonCardType;
//     final String? resAddonCashLimit;
//     final String? resAddonMaskedCardNumber;
//     final String? resAddonCreditLimit;
//     final String? resAddonCardStatusWithDesc;
//     final String? resAddonCustomerName;
//
//     ResAddonDetail({
//         this.resAddonCardType,
//         this.resAddonCashLimit,
//         this.resAddonMaskedCardNumber,
//         this.resAddonCreditLimit,
//         this.resAddonCardStatusWithDesc,
//         this.resAddonCustomerName,
//     });
//
//     factory ResAddonDetail.fromJson(Map<String, dynamic> json) => ResAddonDetail(
//         resAddonCardType: json["resAddonCardType"],
//         resAddonCashLimit: json["resAddonCashLimit"],
//         resAddonMaskedCardNumber: json["resAddonMaskedCardNumber"],
//         resAddonCreditLimit: json["resAddonCreditLimit"],
//         resAddonCardStatusWithDesc: json["resAddonCardStatusWithDesc"],
//         resAddonCustomerName: json["resAddonCustomerName"],
//     );
//
//     Map<String, dynamic> toJson() => {
//         "resAddonCardType": resAddonCardType,
//         "resAddonCashLimit": resAddonCashLimit,
//         "resAddonMaskedCardNumber": resAddonMaskedCardNumber,
//         "resAddonCreditLimit": resAddonCreditLimit,
//         "resAddonCardStatusWithDesc": resAddonCardStatusWithDesc,
//         "resAddonCustomerName": resAddonCustomerName,
//     };
// }
//
// class TxnDetails {
//     final String? resRefNo;
//     final String? resTxnCardNum;
//     final String? resAmount;
//     final String? resTransDate;
//     final String? resTransDesc;
//     final String? resDebitCreditIndicator;
//
//     TxnDetails({
//         this.resRefNo,
//         this.resTxnCardNum,
//         this.resAmount,
//         this.resTransDate,
//         this.resTransDesc,
//         this.resDebitCreditIndicator,
//     });
//
//     factory TxnDetails.fromJson(Map<String, dynamic> json) => TxnDetails(
//         resRefNo: json["resRefNo"],
//         resTxnCardNum: json["resTxnCardNum"],
//         resAmount: json["resAmount"],
//         resTransDate: json["resTransDate"],
//         resTransDesc: json["resTransDesc"],
//         resDebitCreditIndicator: json["resDebitCreditIndicator"],
//     );
//
//     Map<String, dynamic> toJson() => {
//         "resRefNo": resRefNo,
//         "resTxnCardNum": resTxnCardNum,
//         "resAmount": resAmount,
//         "resTransDate": resTransDate,
//         "resTransDesc": resTransDesc,
//         "resDebitCreditIndicator": resDebitCreditIndicator,
//     };
// }
