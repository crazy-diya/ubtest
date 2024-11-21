// To parse this JSON data, do
//
//     final billPaymentRequest = billPaymentRequestFromJson(jsonString);

import 'dart:convert';

BillPaymentRequest billPaymentRequestFromJson(String str) =>
    BillPaymentRequest.fromJson(json.decode(str));

String billPaymentRequestToJson(BillPaymentRequest data) =>
    json.encode(data.toJson());

class BillPaymentRequest {
  BillPaymentRequest({
    this.messageType,
    this.instrumentId,
    this.billerId,
    this.accountNumber,
    this.amount,
    this.remarks,
    //this.serviceCharge,
    this.billPaymentCategory,
  });

  String? messageType;
  int? instrumentId;
  String? billerId;
  String? accountNumber;
  String? amount;
  String? remarks;
  //String? serviceCharge;
  String? billPaymentCategory;

  factory BillPaymentRequest.fromJson(Map<String, dynamic> json) =>
      BillPaymentRequest(
        messageType: json["messageType"],
        instrumentId: json["instrumentId"],
        billerId: json["billerId"],
        accountNumber: json["accountNumber"],
        amount: json["amount"],
        remarks: json["remarks"],
        //serviceCharge: json["serviceCharge"],
        billPaymentCategory: json["billPaymentCategory"],
      );

  Map<String, dynamic> toJson() => {
        "messageType": messageType,
        "instrumentId": instrumentId,
        "billerId": billerId,
        "accountNumber": accountNumber,
        "amount": amount,
        "remarks": remarks,
   //"serviceCharge" : serviceCharge,
    "billPaymentCategory" : billPaymentCategory,
      };
}
