


// // To parse this JSON data, do
// //
// //     final portfolioCcDetailsResponse = portfolioCcDetailsResponseFromJson(jsonString);

// import 'dart:convert';

// import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

// PortfolioCcDetailsResponse portfolioCcDetailsResponseFromJson(String str) => PortfolioCcDetailsResponse.fromJson(json.decode(str));

// String portfolioCcDetailsResponseToJson(PortfolioCcDetailsResponse data) => json.encode(data.toJson());

// class PortfolioCcDetailsResponse extends Serializable {
//     final String? resTxnRefNo;
//     final List<ResPrimaryCardDetail>? resPrimaryCardDetails;
//     final List<ResAddonCardDetail>? resAddonCardDetails;
//     final String? resTxnRefCode;
//     final String? resErrCode;
//     final String? resHdrTranId;
//     final String? resCifNumber;
//     final String? resLocalTxnDtTime;
//     final String? resErrMsg;

//     PortfolioCcDetailsResponse({
//         this.resTxnRefNo,
//         this.resPrimaryCardDetails,
//         this.resAddonCardDetails,
//         this.resTxnRefCode,
//         this.resErrCode,
//         this.resHdrTranId,
//         this.resCifNumber,
//         this.resLocalTxnDtTime,
//         this.resErrMsg,
//     });

//     factory PortfolioCcDetailsResponse.fromJson(Map<String, dynamic> json) => PortfolioCcDetailsResponse(
//         resTxnRefNo: json["resTxnRefNo"],
//         resPrimaryCardDetails: json["resPrimaryCardDetails"] == null ? [] : List<ResPrimaryCardDetail>.from(json["resPrimaryCardDetails"]!.map((x) => ResPrimaryCardDetail.fromJson(x))),
//         resAddonCardDetails: json["resAddonCardDetails"] == null ? [] : List<ResAddonCardDetail>.from(json["resAddonCardDetails"]!.map((x) => ResAddonCardDetail.fromJson(x))),
//         resTxnRefCode: json["resTxnRefCode"],
//         resErrCode: json["resErrCode"],
//         resHdrTranId: json["resHdrTranID"],
//         resCifNumber: json["resCIFNumber"],
//         resLocalTxnDtTime: json["resLocalTxnDtTime"],
//         resErrMsg: json["resErrMsg"],
//     );

//     Map<String, dynamic> toJson() => {
//         "resTxnRefNo": resTxnRefNo,
//         "resPrimaryCardDetails": resPrimaryCardDetails == null ? [] : List<dynamic>.from(resPrimaryCardDetails!.map((x) => x.toJson())),
//         "resAddonCardDetails": resAddonCardDetails == null ? [] : List<dynamic>.from(resAddonCardDetails!.map((x) => x.toJson())),
//         "resTxnRefCode": resTxnRefCode,
//         "resErrCode": resErrCode,
//         "resHdrTranID": resHdrTranId,
//         "resCIFNumber": resCifNumber,
//         "resLocalTxnDtTime": resLocalTxnDtTime,
//         "resErrMsg": resErrMsg,
//     };
// }

// class ResAddonCardDetail {
//     final String? resCmsAccNo;
//     final String? resAddonCardTypeWithDesc;
//     final String? resAddonMaskedCardNumber;
//     final String? resAddonCardStatusWithDesc;
//     final String? resAddonCashLimit;
//     final String? resAddonCustomerName;
//     final String? resAddonCreditLimit;

//     ResAddonCardDetail({
//         this.resCmsAccNo,
//         this.resAddonCardTypeWithDesc,
//         this.resAddonMaskedCardNumber,
//         this.resAddonCardStatusWithDesc,
//         this.resAddonCashLimit,
//         this.resAddonCustomerName,
//         this.resAddonCreditLimit,
//     });

//     factory ResAddonCardDetail.fromJson(Map<String, dynamic> json) => ResAddonCardDetail(
//         resCmsAccNo: json["resCMSAccNo"],
//         resAddonCardTypeWithDesc: json["resAddonCardTypeWithDesc"],
//         resAddonMaskedCardNumber: json["resAddonMaskedCardNumber"],
//         resAddonCardStatusWithDesc: json["resAddonCardStatusWithDesc"],
//         resAddonCashLimit: json["resAddonCashLimit"],
//         resAddonCustomerName: json["resAddonCustomerName"],
//         resAddonCreditLimit: json["resAddonCreditLimit"],
//     );

//     Map<String, dynamic> toJson() => {
//         "resCMSAccNo": resCmsAccNo,
//         "resAddonCardTypeWithDesc": resAddonCardTypeWithDesc,
//         "resAddonMaskedCardNumber": resAddonMaskedCardNumber,
//         "resAddonCardStatusWithDesc": resAddonCardStatusWithDesc,
//         "resAddonCashLimit": resAddonCashLimit,
//         "resAddonCustomerName": resAddonCustomerName,
//         "resAddonCreditLimit": resAddonCreditLimit,
//     };
// }

// class ResPrimaryCardDetail {
//     final String? resCurrentOutstandingBalance;
//     final String? resMaskedPrimaryCardNumber;
//     final String? resCmsAccNo;
//     final String? resMinAmtDue;
//     final String? resAvailableBalance;
//     final String? resPymtDueDate;
//     final String? resCardTypeWithDesc;
//     final String? resCardStatusWithDesc;
//     final String? resCashLimit;
//     final String? resCardCustName;
//     final List<ResLast5Txn>? resLast5Txns;
//     final String? resCreditLimit;

//     ResPrimaryCardDetail({
//         this.resCurrentOutstandingBalance,
//         this.resMaskedPrimaryCardNumber,
//         this.resCmsAccNo,
//         this.resMinAmtDue,
//         this.resAvailableBalance,
//         this.resPymtDueDate,
//         this.resCardTypeWithDesc,
//         this.resCardStatusWithDesc,
//         this.resCashLimit,
//         this.resCardCustName,
//         this.resLast5Txns,
//         this.resCreditLimit,
//     });

//     factory ResPrimaryCardDetail.fromJson(Map<String, dynamic> json) => ResPrimaryCardDetail(
//         resCurrentOutstandingBalance: json["resCurrentOutstandingBalance"],
//         resMaskedPrimaryCardNumber: json["resMaskedPrimaryCardNumber"],
//         resCmsAccNo: json["resCMSAccNo"],
//         resMinAmtDue: json["resMinAmtDue"],
//         resAvailableBalance: json["resAvailableBalance"],
//         resPymtDueDate: json["resPymtDueDate"],
//         resCardTypeWithDesc: json["resCardTypeWithDesc"],
//         resCardStatusWithDesc: json["resCardStatusWithDesc"],
//         resCashLimit: json["resCashLimit"],
//         resCardCustName: json["resCardCustName"],
//         resLast5Txns: json["resLast5Txns"] == null ? [] : List<ResLast5Txn>.from(json["resLast5Txns"]!.map((x) => ResLast5Txn.fromJson(x))),
//         resCreditLimit: json["resCreditLimit"],
//     );

//     Map<String, dynamic> toJson() => {
//         "resCurrentOutstandingBalance": resCurrentOutstandingBalance,
//         "resMaskedPrimaryCardNumber": resMaskedPrimaryCardNumber,
//         "resCMSAccNo": resCmsAccNo,
//         "resMinAmtDue": resMinAmtDue,
//         "resAvailableBalance": resAvailableBalance,
//         "resPymtDueDate": resPymtDueDate,
//         "resCardTypeWithDesc": resCardTypeWithDesc,
//         "resCardStatusWithDesc": resCardStatusWithDesc,
//         "resCashLimit": resCashLimit,
//         "resCardCustName": resCardCustName,
//         "resLast5Txns": resLast5Txns == null ? [] : List<dynamic>.from(resLast5Txns!.map((x) => x.toJson())),
//         "resCreditLimit": resCreditLimit,
//     };
// }

// class ResLast5Txn {
//     final String? resTxnCardNum;
//     final String? resRefNo;
//     final String? resDebitCreditIndicator;
//     final String? resTransDesc;
//     final String? resAmount;
//     final String? resTransDate;

//     ResLast5Txn({
//         this.resTxnCardNum,
//         this.resRefNo,
//         this.resDebitCreditIndicator,
//         this.resTransDesc,
//         this.resAmount,
//         this.resTransDate,
//     });

//     factory ResLast5Txn.fromJson(Map<String, dynamic> json) => ResLast5Txn(
//         resTxnCardNum: json["resTxnCardNum"],
//         resRefNo: json["resRefNo"],
//         resDebitCreditIndicator: json["resDebitCreditIndicator"],
//         resTransDesc: json["resTransDesc"],
//         resAmount: json["resAmount"],
//         resTransDate: json["resTransDate"],
//     );

//     Map<String, dynamic> toJson() => {
//         "resTxnCardNum": resTxnCardNum,
//         "resRefNo": resRefNo,
//         "resDebitCreditIndicator": resDebitCreditIndicator,
//         "resTransDesc": resTransDesc,
//         "resAmount": resAmount,
//         "resTransDate": resTransDate,
//     };
// }



// To parse this JSON data, do
//
//     final portfolioCcDetailsResponse = portfolioCcDetailsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

PortfolioCcDetailsResponse portfolioCcDetailsResponseFromJson(String str) => PortfolioCcDetailsResponse.fromJson(json.decode(str));

String portfolioCcDetailsResponseToJson(PortfolioCcDetailsResponse data) => json.encode(data.toJson());

class PortfolioCcDetailsResponse extends Serializable {
    final List<ResAddonCardDetail>? resAddonCardDetails;
    final String? resTxnRefCode;
    final String? resErrCode;
    final String? resHdrTranId;
    final String? resCifNumber;
    final String? resLocalTxnDtTime;
    final String? resErrMsg;
    final String? resTxnRefNo;
    final List<ResPrimaryCardDetail>? resPrimaryCardDetails;

    PortfolioCcDetailsResponse({
        this.resAddonCardDetails,
        this.resTxnRefCode,
        this.resErrCode,
        this.resHdrTranId,
        this.resCifNumber,
        this.resLocalTxnDtTime,
        this.resErrMsg,
        this.resTxnRefNo,
        this.resPrimaryCardDetails,
    });

    factory PortfolioCcDetailsResponse.fromJson(Map<String, dynamic> json) => PortfolioCcDetailsResponse(
        resAddonCardDetails: json["resAddonCardDetails"] == null ? [] : List<ResAddonCardDetail>.from(json["resAddonCardDetails"]!.map((x) => ResAddonCardDetail.fromJson(x))),
        resTxnRefCode: json["resTxnRefCode"],
        resErrCode: json["resErrCode"],
        resHdrTranId: json["resHdrTranID"],
        resCifNumber: json["resCIFNumber"],
        resLocalTxnDtTime: json["resLocalTxnDtTime"],
        resErrMsg: json["resErrMsg"],
        resTxnRefNo: json["resTxnRefNo"],
        resPrimaryCardDetails: json["resPrimaryCardDetails"] == null ? [] : List<ResPrimaryCardDetail>.from(json["resPrimaryCardDetails"]!.map((x) => ResPrimaryCardDetail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "resAddonCardDetails": resAddonCardDetails == null ? [] : List<dynamic>.from(resAddonCardDetails!.map((x) => x.toJson())),
        "resTxnRefCode": resTxnRefCode,
        "resErrCode": resErrCode,
        "resHdrTranID": resHdrTranId,
        "resCIFNumber": resCifNumber,
        "resLocalTxnDtTime": resLocalTxnDtTime,
        "resErrMsg": resErrMsg,
        "resTxnRefNo": resTxnRefNo,
        "resPrimaryCardDetails": resPrimaryCardDetails == null ? [] : List<dynamic>.from(resPrimaryCardDetails!.map((x) => x.toJson())),
    };
}

class ResAddonCardDetail {
    final String? resCmsAccNo;
    final String? resAddonCardTypeWithDesc;
    final String? resAddonMaskedCardNumber;
    final String? resAddonCardStatusWithDesc;
    final String? resAddonCashLimit;
    final String? resAddonCustomerName;
    final String? resAddonCreditLimit;

    ResAddonCardDetail({
        this.resCmsAccNo,
        this.resAddonCardTypeWithDesc,
        this.resAddonMaskedCardNumber,
        this.resAddonCardStatusWithDesc,
        this.resAddonCashLimit,
        this.resAddonCustomerName,
        this.resAddonCreditLimit,
    });

    factory ResAddonCardDetail.fromJson(Map<String, dynamic> json) => ResAddonCardDetail(
        resCmsAccNo: json["resCMSAccNo"],
        resAddonCardTypeWithDesc: json["resAddonCardTypeWithDesc"],
        resAddonMaskedCardNumber: json["resAddonMaskedCardNumber"],
        resAddonCardStatusWithDesc: json["resAddonCardStatusWithDesc"],
        resAddonCashLimit: json["resAddonCashLimit"],
        resAddonCustomerName: json["resAddonCustomerName"],
        resAddonCreditLimit: json["resAddonCreditLimit"],
    );

    Map<String, dynamic> toJson() => {
        "resCMSAccNo": resCmsAccNo,
        "resAddonCardTypeWithDesc": resAddonCardTypeWithDesc,
        "resAddonMaskedCardNumber": resAddonMaskedCardNumber,
        "resAddonCardStatusWithDesc": resAddonCardStatusWithDesc,
        "resAddonCashLimit": resAddonCashLimit,
        "resAddonCustomerName": resAddonCustomerName,
        "resAddonCreditLimit": resAddonCreditLimit,
    };
}

class ResPrimaryCardDetail {
    final String? resCashLimit;
    final String? resCmsAccNo;
    final String? resMinAmtDue;
    final String? resAvailableBalance;
    final String? resPymtDueDate;
    final String? resCardTypeWithDesc;
    final String? resCardStatusWithDesc;
    final String? resCardCustName;
    final String? resCreditLimit;
    final String? resCurrentOutstandingBalance;
    final String? resMaskedPrimaryCardNumber;
    final List<ResLast5Txn>? resLast5Txns;

    ResPrimaryCardDetail({
        this.resCashLimit,
        this.resCmsAccNo,
        this.resMinAmtDue,
        this.resAvailableBalance,
        this.resPymtDueDate,
        this.resCardTypeWithDesc,
        this.resCardStatusWithDesc,
        this.resCardCustName,
        this.resCreditLimit,
        this.resCurrentOutstandingBalance,
        this.resMaskedPrimaryCardNumber,
        this.resLast5Txns,
    });

    factory ResPrimaryCardDetail.fromJson(Map<String, dynamic> json) => ResPrimaryCardDetail(
        resCashLimit: json["resCashLimit"],
        resCmsAccNo: json["resCMSAccNo"],
        resMinAmtDue: json["resMinAmtDue"],
        resAvailableBalance: json["resAvailableBalance"],
        resPymtDueDate: json["resPymtDueDate"],
        resCardTypeWithDesc: json["resCardTypeWithDesc"],
        resCardStatusWithDesc: json["resCardStatusWithDesc"],
        resCardCustName: json["resCardCustName"],
        resCreditLimit: json["resCreditLimit"],
        resCurrentOutstandingBalance: json["resCurrentOutstandingBalance"],
        resMaskedPrimaryCardNumber: json["resMaskedPrimaryCardNumber"],
        resLast5Txns: json["resLast5Txns"] == null ? [] : List<ResLast5Txn>.from(json["resLast5Txns"]!.map((x) => ResLast5Txn.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "resCashLimit": resCashLimit,
        "resCMSAccNo": resCmsAccNo,
        "resMinAmtDue": resMinAmtDue,
        "resAvailableBalance": resAvailableBalance,
        "resPymtDueDate": resPymtDueDate,
        "resCardTypeWithDesc": resCardTypeWithDesc,
        "resCardStatusWithDesc": resCardStatusWithDesc,
        "resCardCustName": resCardCustName,
        "resCreditLimit": resCreditLimit,
        "resCurrentOutstandingBalance": resCurrentOutstandingBalance,
        "resMaskedPrimaryCardNumber": resMaskedPrimaryCardNumber,
        "resLast5Txns": resLast5Txns == null ? [] : List<dynamic>.from(resLast5Txns!.map((x) => x.toJson())),
    };
}

class ResLast5Txn {
    final String? resAmount;
    final String? resTransDesc;
    final String? resRefNo;
    final String? resDebitCreditIndicator;
    final String? resTxnCardNum;
    final String? resTransDate;

    ResLast5Txn({
        this.resAmount,
        this.resTransDesc,
        this.resRefNo,
        this.resDebitCreditIndicator,
        this.resTxnCardNum,
        this.resTransDate,
    });

    factory ResLast5Txn.fromJson(Map<String, dynamic> json) => ResLast5Txn(
        resAmount: json["resAmount"],
        resTransDesc: json["resTransDesc"],
        resRefNo: json["resRefNo"],
        resDebitCreditIndicator: json["resDebitCreditIndicator"],
        resTxnCardNum: json["resTxnCardNum"],
        resTransDate: json["resTransDate"],
    );

    Map<String, dynamic> toJson() => {
        "resAmount": resAmount,
        "resTransDesc": resTransDesc,
        "resRefNo": resRefNo,
        "resDebitCreditIndicator": resDebitCreditIndicator,
        "resTxnCardNum": resTxnCardNum,
        "resTransDate": resTransDate,
    };
}


