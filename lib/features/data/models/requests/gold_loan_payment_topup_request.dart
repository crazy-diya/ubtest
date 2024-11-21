// To parse this JSON data, do
//
//     final goldLoanPaymentTopUpRequest = goldLoanPaymentTopUpRequestFromJson(jsonString);

import 'dart:convert';

GoldLoanPaymentTopUpRequest goldLoanPaymentTopUpRequestFromJson(String str) => GoldLoanPaymentTopUpRequest.fromJson(json.decode(str));

String goldLoanPaymentTopUpRequestToJson(GoldLoanPaymentTopUpRequest data) => json.encode(data.toJson());

class GoldLoanPaymentTopUpRequest {
  String? messageType;
  int? instrumentId;
  String? ticketNumber;
  double? amount;
  String? remarks;
  int? isTopUp;

  GoldLoanPaymentTopUpRequest({
    this.messageType,
    this.instrumentId,
    this.ticketNumber,
    this.amount,
    this.remarks,
    this.isTopUp,
  });

  factory GoldLoanPaymentTopUpRequest.fromJson(Map<String, dynamic> json) => GoldLoanPaymentTopUpRequest(
    messageType: json["messageType"],
    instrumentId: json["instrumentId"],
    ticketNumber: json["ticketNumber"],
    amount: json["amount"],
    remarks: json["remarks"],
    isTopUp: json["isTopUp"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "instrumentId": instrumentId,
    "ticketNumber": ticketNumber,
    "amount": amount,
    "remarks": remarks,
    "isTopUp": isTopUp,
  };
}
