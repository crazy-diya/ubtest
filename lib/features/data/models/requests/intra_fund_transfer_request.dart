// To parse this JSON data, do
//
//     final intraFundTransferRequest = intraFundTransferRequestFromJson(jsonString);

import 'dart:convert';

IntraFundTransferRequest intraFundTransferRequestFromJson(String str) => IntraFundTransferRequest.fromJson(json.decode(str));

String intraFundTransferRequestToJson(IntraFundTransferRequest data) => json.encode(data.toJson());

class IntraFundTransferRequest {
  IntraFundTransferRequest({
    this.messageType,
    this.instrumentId,
    this.toBankCode,
    this.toAccountNo,
    this.toAccountName,
    this.transactionCategory,
    this.amount,
    this.remarks,
    this.reference,
    this.mobile,
    this.email,
    this.tranType,
    this.isCreditCardPayment,
  });

  String? messageType;
  int? instrumentId;
  String? toBankCode;
  String? toAccountNo;
  String? toAccountName;
  String? transactionCategory;
  String? amount;
  String? remarks;
  String? reference;
  String? mobile;
  String? email;
  String? tranType;
  bool? isCreditCardPayment;

  factory IntraFundTransferRequest.fromJson(Map<String, dynamic> json) => IntraFundTransferRequest(
    messageType: json["messageType"],
    instrumentId: json["instrumentId"],
    toBankCode: json["toBankCode"],
    toAccountNo: json["toAccountNo"],
    toAccountName: json["toAccountName"],
    transactionCategory: json["transactionCategory"],
    amount: json["amount"],
    remarks: json["remarks"],
    reference: json["reference"],
    mobile: json["mobile"],
    email: json["email"],
    tranType: json["tranType"],
    isCreditCardPayment: json["isCreditCardPayment"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "instrumentId": instrumentId,
    "toBankCode": toBankCode,
    "toAccountNo": toAccountNo,
    "toAccountName": toAccountName,
    "transactionCategory": transactionCategory,
    "amount": amount,
    "remarks": remarks,
    "reference": reference,
    "mobile": mobile,
    "email": email,
    "tranType": tranType,
    "isCreditCardPayment": isCreditCardPayment,
  };
}
