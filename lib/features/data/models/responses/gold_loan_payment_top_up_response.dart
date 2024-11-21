// To parse this JSON data, do
//
//     final goldLoanPaymentTopUpResponse = goldLoanPaymentTopUpResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

GoldLoanPaymentTopUpResponse goldLoanPaymentTopUpResponseFromJson(String str) => GoldLoanPaymentTopUpResponse.fromJson(json.decode(str));

String goldLoanPaymentTopUpResponseToJson(GoldLoanPaymentTopUpResponse data) => json.encode(data.toJson());

class GoldLoanPaymentTopUpResponse extends Serializable {
  DateTime? date;
  String? refNo;
  String? amount;
  String? refId;
  String? status;
  String? description;
  String? paymentType;
  String? toBePaidPayableAmount;
  String? isTopup;
  String? receiptNo;

  GoldLoanPaymentTopUpResponse({
    this.date,
    this.refNo,
    this.amount,
    this.refId,
    this.status,
    this.description,
    this.paymentType,
    this.toBePaidPayableAmount,
    this.isTopup,
    this.receiptNo,
  });

  factory GoldLoanPaymentTopUpResponse.fromJson(Map<String, dynamic> json) => GoldLoanPaymentTopUpResponse(
    date: DateTime.parse(json["date"]),
    refNo: json["RefNo"],
    amount: json["Amount"],
    refId: json["RefID"],
    status: json["status"],
    description: json["description"],
    paymentType: json["PaymentType"],
    toBePaidPayableAmount: json["ToBePaidPayableAmount"],
    isTopup: json["IsTopup"],
    receiptNo: json["ReceiptNo"],
  );

  Map<String, dynamic> toJson() => {
    "date": date!.toIso8601String(),
    "RefNo": refNo,
    "Amount": amount,
    "RefID": refId,
    "status": status,
    "description": description,
    "PaymentType": paymentType,
    "ToBePaidPayableAmount": toBePaidPayableAmount,
    "IsTopup": isTopup,
    "ReceiptNo": receiptNo,
  };
}
