// To parse this JSON data, do
//
//     final transactionDetailsResponse = transactionDetailsResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';


TransactionDetailsResponse transactionDetailsResponseFromJson(String str) => TransactionDetailsResponse.fromJson(json.decode(str));

String transactionDetailsResponseToJson(TransactionDetailsResponse data) => json.encode(data.toJson());

class TransactionDetailsResponse  extends Serializable{
    final int? count;
    final List<TxnDetailList>? txnDetailList;

    TransactionDetailsResponse({
        this.count,
        this.txnDetailList,
    });

    factory TransactionDetailsResponse.fromJson(Map<String, dynamic> json) => TransactionDetailsResponse(
        count: json["count"],
        txnDetailList: json["txnDetailList"] == null ? [] : List<TxnDetailList>.from(json["txnDetailList"]!.map((x) => TxnDetailList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "txnDetailList": txnDetailList == null ? [] : List<dynamic>.from(txnDetailList!.map((x) => x.toJson())),
    };
}

class TxnDetailList {
    final String? transactionId;
    final String? channel;
    final String? txnType;
    final String? txnDescription;
    final String? traceNumber;
    final String? fromBankCode;
    final String? fromBranchCode;
    final String? fromAccountNumber;
    final String? fromAccountName;
    final String? toBankCode;
    final String? toBranchCode;
    final String? toAccountNumber;
    final String? toAccountName;
    final String? mobileNumber;
    final String? billReffrenceNumber;
    final String? payeeId;
    final String? payeeName;
    final String? billCategoryId;
    final String? billCategoryName;
    final String? billProviderId;
    final String? billProviderName;
    final String? billProviderLogo;
    final String? billerId;
    final String? billerName;
    final String? remarks;
    final num? amount;
    final num? serviceFee;
    final String? responseCode;
    final String? status;
    final DateTime? createdDate;
    final DateTime? modifiedDate;
    final String? email;
    final String? reference;
    final String? crDr;
    final String? txnCategory;

    TxnDetailList({
        this.transactionId,
        this.channel,
        this.txnType,
        this.txnDescription,
        this.traceNumber,
        this.fromBankCode,
        this.fromBranchCode,
        this.fromAccountNumber,
        this.fromAccountName,
        this.toBankCode,
        this.toBranchCode,
        this.toAccountNumber,
        this.toAccountName,
        this.mobileNumber,
        this.billReffrenceNumber,
        this.payeeId,
        this.payeeName,
        this.billCategoryId,
        this.billCategoryName,
        this.billProviderId,
        this.billProviderName,
        this.billProviderLogo,
        this.billerId,
        this.billerName,
        this.remarks,
        this.amount,
        this.serviceFee,
        this.responseCode,
        this.status,
        this.createdDate,
        this.modifiedDate,
        this.email,
        this.reference,
        this.crDr,
        this.txnCategory,
    });

    factory TxnDetailList.fromJson(Map<String, dynamic> json) => TxnDetailList(
        transactionId: json["transaction_id"],
        channel: json["channel"],
        txnType: json["txn_type"],
        txnDescription: json["txn_description"],
        traceNumber: json["trace_number"],
        fromBankCode: json["from_bank_code"],
        fromBranchCode: json["from_branch_code"],
        fromAccountNumber: json["from_account_number"],
        fromAccountName: json["from_account_name"],
        toBankCode: json["to_bank_code"],
        toBranchCode: json["to_branch_code"],
        toAccountNumber: json["to_account_number"],
        toAccountName: json["to_account_name"],
        mobileNumber: json["mobile_number"],
        billReffrenceNumber: json["bill_reffrence_number"],
        payeeId: json["payee_id"],
        payeeName: json["payee_name"],
        billCategoryId: json["bill_category_id"],
        billCategoryName: json["bill_category_name"],
        billProviderId: json["bill_provider_id"],
        billProviderName: json["bill_provider_name"],
        billProviderLogo: json["bill_provider_logo"],
        billerId: json["biller_id"],
        billerName: json["biller_name"],
        remarks: json["remarks"],
        amount: json["amount"]?.toDouble(),
        serviceFee: json["service_fee"],
        responseCode: json["responseCode"],
        status: json["status"],
        createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
        modifiedDate: json["modifiedDate"] == null ? null : DateTime.parse(json["modifiedDate"]),
        email: json["email"],
        reference: json["reference"],
        crDr: json["cr_dr"],
        txnCategory: json["txnCategory"],
    );

    Map<String, dynamic> toJson() => {
        "transaction_id": transactionId,
        "channel": channel,
        "txn_type": txnType,
        "txn_description": txnDescription,
        "trace_number": traceNumber,
        "from_bank_code": fromBankCode,
        "from_branch_code": fromBranchCode,
        "from_account_number": fromAccountNumber,
        "from_account_name": fromAccountName,
        "to_bank_code": toBankCode,
        "to_branch_code": toBranchCode,
        "to_account_number": toAccountNumber,
        "to_account_name": toAccountName,
        "mobile_number": mobileNumber,
        "bill_reffrence_number": billReffrenceNumber,
        "payee_id": payeeId,
        "payee_name": payeeName,
        "bill_category_id": billCategoryId,
        "bill_category_name": billCategoryName,
        "bill_provider_id": billProviderId,
        "bill_provider_name": billProviderName,
        "bill_provider_logo": billProviderLogo,
        "biller_id": billerId,
        "biller_name": billerName,
        "remarks": remarks,
        "amount": amount,
        "service_fee": serviceFee,
        "responseCode": responseCode,
        "status": status,
        "createdDate": createdDate?.toIso8601String(),
        "modifiedDate": modifiedDate?.toIso8601String(),
        "email": email,
        "reference": reference,
        "cr_dr": crDr,
        "txnCategory": txnCategory,
    };
}

