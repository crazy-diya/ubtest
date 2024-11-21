// To parse this JSON data, do
//
//     final accountTransactionHistoryresponse = accountTransactionHistoryresponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';

AccountTransactionHistoryresponse accountTransactionHistoryresponseFromJson(String str) => AccountTransactionHistoryresponse.fromJson(json.decode(str));

String accountTransactionHistoryresponseToJson(AccountTransactionHistoryresponse data) => json.encode(data.toJson());

class AccountTransactionHistoryresponse extends Serializable{
  int? count;
  double? totalDrAmount;
  double? totalCrAmount;
  DateTime? firstTxnDate;
  DateTime? lastTxnDate;
  List<RecentTransactionList>? recentTransactionList;

  AccountTransactionHistoryresponse({
     this.count,
     this.totalDrAmount,
     this.totalCrAmount,
     this.firstTxnDate,
     this.lastTxnDate,
     this.recentTransactionList,
  });

  factory AccountTransactionHistoryresponse.fromJson(Map<String, dynamic> json) => AccountTransactionHistoryresponse(
    count: json["count"],
    firstTxnDate: json["firstTxnDate"] == null ? null : DateTime.parse(json["firstTxnDate"]),
    lastTxnDate: json["lastTxnDate"] == null ? null : DateTime.parse(json["lastTxnDate"]),
    totalDrAmount:json["totalDrAmount"] ,
    totalCrAmount:json["totalCrAmount"],

  recentTransactionList: json["recentTransactionList"] == null ? [] : List<RecentTransactionList>.from(json["recentTransactionList"]!.map((x) => RecentTransactionList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "firstTxnDate": firstTxnDate?.toIso8601String(),
    "lastTxnDate": lastTxnDate?.toIso8601String(),
    "totalCrAmount": totalCrAmount,
    "recentTransactionList": List<dynamic>.from(recentTransactionList??[].map((x) => x.toJson())),

  };
}

class RecentTransactionList {
  String? transactionId;
  String ?channel;
  String? txnType;
  String? traceNumber;
  String? fromBankCode;
  String? fromBranchCode;
  String? fromAccountNumber;
  String ?fromAccountName;
  String ?toBankCode;
  String ?toBranchCode;
  String ?toAccountNumber;
  String ?toAccountName;
  String? mobileNumber;
  String? billReffrenceNumber;
  String? payeeId;
  String? payeeName;
  String? billCategoryId;
  String? billCategoryName;
  String? billProviderId;
  String? billProviderName;
  String? billerId;
  String? billerName;
  String?remarks;
  num? amount;
  num? serviceFee;
  String? responseCode;
  String ?status;
  DateTime? createdDate;
  String? reference;
  String ?crDr;
  String ?email;
  DateTime ?txnTime;

  RecentTransactionList({
     this.transactionId,
     this.channel,
     this.txnType,
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
     this.billerId,
     this.billerName,
     this.remarks,
     this.amount,
     this.serviceFee,
     this.responseCode,
     this.status,
     this.createdDate,
     this.reference,
     this.crDr,
     this.email,
     this.txnTime
  });

  factory RecentTransactionList.fromJson(Map<String, dynamic> json) => RecentTransactionList(
    transactionId: json["transaction_id"],
    channel: json["channel"],
    txnType: json["txn_type"],
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
    billerId: json["biller_id"],
    billerName: json["biller_name"],
    remarks: json["remarks"],
    amount: json["amount"]??0.00,
    serviceFee: json["service_fee"]??0.00,
    responseCode: json["responseCode"],
    status: json["status"],
    createdDate:  DateTime.parse(
            json["createdDate"].toString().isDate() == true
                ? json["createdDate"]
                : json["createdDate"].toString().toValidDate()),
    reference: json["reference"],
    crDr: json["cr_dr"],
    email: json["email"],
    txnTime: json["txnTime"] == null ? null : DateTime.parse(json["txnTime"]),
  );

  Map<String, dynamic> toJson() => {
    "transaction_id": transactionId,
    "channel": channel,
    "txn_type": txnType,
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
    "biller_id": billerId,
    "biller_name": billerName,
    "remarks": remarks,
    "amount": amount,
    "service_fee": serviceFee,
    "responseCode": responseCode,
    "status": status,
    "createdDate": createdDate?.toIso8601String(),
    "reference":     txnTime?.toIso8601String(),
    "cr_dr": crDr,
    "email": email,
  };
}
