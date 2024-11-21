// To parse this JSON data, do
//
//     final transactionFilterResponse = transactionFilterResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/transcation_details_response.dart';

TransactionFilterResponse transactionFilterResponseFromJson(String str) => TransactionFilterResponse.fromJson(json.decode(str));

String transactionFilterResponseToJson(TransactionFilterResponse data) => json.encode(data.toJson());

class TransactionFilterResponse extends Serializable{
  int? count;
  List<TxnDetailList>? txnDetailListFiltered;

  TransactionFilterResponse({
     this.count,
     this.txnDetailListFiltered,
  });

  factory TransactionFilterResponse.fromJson(Map<String, dynamic> json) => TransactionFilterResponse(
    count: json["count"],
    txnDetailListFiltered: List<TxnDetailList>.from(json["txnDetailListFiltered"].map((x) => TxnDetailList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "txnDetailListFiltered": List<dynamic>.from(txnDetailListFiltered!.map((x) => x.toJson())),
  };
}

// class TxnDetailListFiltered {
//   String transactionId;
//   String channel;
//   String txnType;
//   String traceNumber;
//   String fromBankCode;
//   String fromBranchCode;
//   String fromAccountNumber;
//   String fromAccountName;
//   String toBankCode;
//   String toBranchCode;
//   String toAccountNumber;
//   String toAccountName;
//   String mobileNumber;
//   String billReffrenceNumber;
//   String payeeId;
//   String payeeName;
//   String billCategoryId;
//   String billCategoryName;
//   String billProviderId;
//   String billProviderName;
//   String billerId;
//   String billerName;
//   String remarks;
//   String amount;
//   double serviceFee;
//   String responseCode;
//   String status;
//   String modifiedDate;
//   String reference;
//   String crDr;
//
//   TxnDetailListFiltered({
//     required this.transactionId,
//     required this.channel,
//     required this.txnType,
//     required this.traceNumber,
//     required this.fromBankCode,
//     required this.fromBranchCode,
//     required this.fromAccountNumber,
//     required this.fromAccountName,
//     required this.toBankCode,
//     required this.toBranchCode,
//     required this.toAccountNumber,
//     required this.toAccountName,
//     required this.mobileNumber,
//     required this.billReffrenceNumber,
//     required this.payeeId,
//     required this.payeeName,
//     required this.billCategoryId,
//     required this.billCategoryName,
//     required this.billProviderId,
//     required this.billProviderName,
//     required this.billerId,
//     required this.billerName,
//     required this.remarks,
//     required this.amount,
//     required this.serviceFee,
//     required this.responseCode,
//     required this.status,
//     required this.modifiedDate,
//     required this.reference,
//     required this.crDr,
//   });
//
//   factory TxnDetailListFiltered.fromJson(Map<String, dynamic> json) => TxnDetailListFiltered(
//     transactionId: json["transaction_id"],
//     channel: json["channel"],
//     txnType: json["txn_type"],
//     traceNumber: json["trace_number"],
//     fromBankCode: json["from_bank_code"],
//     fromBranchCode: json["from_branch_code"],
//     fromAccountNumber: json["from_account_number"],
//     fromAccountName: json["from_account_name"],
//     toBankCode: json["to_bank_code"],
//     toBranchCode: json["to_branch_code"],
//     toAccountNumber: json["to_account_number"],
//     toAccountName: json["to_account_name"],
//     mobileNumber: json["mobile_number"],
//     billReffrenceNumber: json["bill_reffrence_number"],
//     payeeId: json["payee_id"],
//     payeeName: json["payee_name"],
//     billCategoryId: json["bill_category_id"],
//     billCategoryName: json["bill_category_name"],
//     billProviderId: json["bill_provider_id"],
//     billProviderName: json["bill_provider_name"],
//     billerId: json["biller_id"],
//     billerName: json["biller_name"],
//     remarks: json["remarks"],
//     amount: json["amount"],
//     serviceFee: json["service_fee"],
//     responseCode: json["responseCode"],
//     status: json["status"],
//     modifiedDate: json["modifiedDate"],
//     reference: json["reference"],
//     crDr: json["cr_dr"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "transaction_id": transactionId,
//     "channel": channel,
//     "txn_type": txnType,
//     "trace_number": traceNumber,
//     "from_bank_code": fromBankCode,
//     "from_branch_code": fromBranchCode,
//     "from_account_number": fromAccountNumber,
//     "from_account_name": fromAccountName,
//     "to_bank_code": toBankCode,
//     "to_branch_code": toBranchCode,
//     "to_account_number": toAccountNumber,
//     "to_account_name": toAccountName,
//     "mobile_number": mobileNumber,
//     "bill_reffrence_number": billReffrenceNumber,
//     "payee_id": payeeId,
//     "payee_name": payeeName,
//     "bill_category_id": billCategoryId,
//     "bill_category_name": billCategoryName,
//     "bill_provider_id": billProviderId,
//     "bill_provider_name": billProviderName,
//     "biller_id": billerId,
//     "biller_name": billerName,
//     "remarks": remarks,
//     "amount": amount,
//     "service_fee": serviceFee,
//     "responseCode": responseCode,
//     "status": status,
//     "modifiedDate": modifiedDate,
//     "reference": reference,
//     "cr_dr": crDr,
//   };
// }

// class TxnDetailListFiltered {
//   TxnDetailListFiltered(
//       {this.transactionId,
//         this.channel,
//         this.txnType,
//         this.traceNumber,
//         this.fromBankCode,
//         this.fromBranchCode,
//         this.fromAccountNumber,
//         this.fromAccountName,
//         this.toBankCode,
//         this.toBranchCode,
//         this.toAccountNumber,
//         this.toAccountName,
//         this.mobileNumber,
//         this.billReffrenceNumber,
//         this.payeeId,
//         this.payeeName,
//         this.billCategoryId,
//         this.billCategoryName,
//         this.billProviderId,
//         this.billProviderName,
//         this.billerId,
//         this.billerName,
//         this.remarks,
//         this.crDr,
//         this.amount,
//         this.responseCode,
//         this.status,
//         this.modifiedDate,
//         this.serviceFee,
//         this.reference});
//
//   String? transactionId;
//   String? channel;
//   String? txnType;
//   String? traceNumber;
//   String? fromBankCode;
//   String? fromBranchCode;
//   String? fromAccountNumber;
//   String? fromAccountName;
//   String? toBankCode;
//   String? toBranchCode;
//   String? toAccountNumber;
//   String? toAccountName;
//   String? mobileNumber;
//   String? billReffrenceNumber;
//   String? payeeId;
//   String? payeeName;
//   String? billCategoryId;
//   String? billCategoryName;
//   String? billProviderId;
//   String? billProviderName;
//   String? billerId;
//   String? billerName;
//   String? remarks;
//   String? crDr;
//   String? amount;
//   String? responseCode;
//   String? status;
//   String? modifiedDate;
//   double? serviceFee;
//   String? reference;
//
//   factory TxnDetailListFiltered.fromJson(Map<String, dynamic> json) => TxnDetailListFiltered(
//     transactionId: json["transaction_id"],
//     channel: json["channel"],
//     txnType: json["txn_type"],
//     traceNumber: json["trace_number"],
//     fromBankCode: json["from_bank_code"],
//     fromBranchCode: json["from_branch_code"],
//     fromAccountNumber: json["from_account_number"],
//     fromAccountName: json["from_account_name"],
//     toBankCode: json["to_bank_code"],
//     toBranchCode: json["to_branch_code"],
//     toAccountNumber: json["to_account_number"],
//     toAccountName: json["to_account_name"],
//     mobileNumber: json["mobile_number"],
//     billReffrenceNumber: json["bill_reffrence_number"],
//     payeeId: json["payee_id"],
//     payeeName: json["payee_name"],
//     billCategoryId: json["bill_category_id"],
//     billCategoryName: json["bill_category_name"],
//     billProviderId: json["bill_provider_id"],
//     billProviderName: json["bill_provider_name"],
//     billerId: json["biller_id"],
//     billerName: json["biller_name"],
//     remarks: json["remarks"],
//     crDr: json["cr_dr"],
//     amount: json["amount"].toString(),
//     responseCode: json["responseCode"],
//     status: json["status"],
//     modifiedDate: json["modifiedDate"],
//     reference: json["reference"],
//     serviceFee: json["service_fee"].toDouble(),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "transaction_id": transactionId,
//     "channel": channel,
//     "txn_type": txnType,
//     "trace_number": traceNumber,
//     "from_bank_code": fromBankCode,
//     "from_branch_code": fromBranchCode,
//     "from_account_number": fromAccountNumber,
//     "from_account_name": fromAccountName,
//     "to_bank_code": toBankCode,
//     "to_branch_code": toBranchCode,
//     "to_account_number": toAccountNumber,
//     "to_account_name": toAccountName,
//     "mobile_number": mobileNumber,
//     "bill_reffrence_number": billReffrenceNumber,
//     "payee_id": payeeId,
//     "payee_name": payeeName,
//     "bill_category_id": billCategoryId,
//     "bill_category_name": billCategoryName,
//     "bill_provider_id": billProviderId,
//     "bill_provider_name": billProviderName,
//     "biller_id": billerId,
//     "biller_name": billerName,
//     "remarks": remarks,
//     "cr_dr": crDr,
//     "amount": amount,
//     "responseCode": responseCode,
//     "status": status,
//     "modifiedDate": modifiedDate,
//     "service_fee": serviceFee,
//     "reference": reference,
//   };
// }
