// To parse this JSON data, do
//
//     final intraFundTransferResponse = intraFundTransferResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

IntraFundTransferResponse intraFundTransferResponseFromJson(String str) => IntraFundTransferResponse.fromJson(json.decode(str));

String intraFundTransferResponseToJson(IntraFundTransferResponse data) => json.encode(data.toJson());

class IntraFundTransferResponse extends Serializable {
  String? fromAccountNo;
  String? toAccountNo;
  String? stan;
  // NotificationServiceResponse? notificationServiceResponse;
  String? transactionAmount;
  String? transactionStatus;
  String? responseCode;
  String? transactionCategory;
  String? remarks;
  String? transactionId;
  String? referenceNumber;

  IntraFundTransferResponse({
    this.fromAccountNo,
    this.toAccountNo,
    this.stan,
    // this.notificationServiceResponse,
    this.transactionAmount,
    this.transactionStatus,
    this.responseCode,
    this.transactionCategory,
    this.remarks,
    this.transactionId,
    this.referenceNumber,
  });

  factory IntraFundTransferResponse.fromJson(Map<String, dynamic> json) => IntraFundTransferResponse(
    fromAccountNo: json["fromAccountNo"],
    toAccountNo: json["toAccountNo"],
    stan: json["stan"],
    // notificationServiceResponse: NotificationServiceResponse.fromJson(json["notificationServiceResponse"]),
        transactionAmount: json["transactionAmount"],
    transactionStatus: json["transactionStatus"],
    responseCode: json["responseCode"],
    transactionCategory: json["transactionCategory"],
    remarks: json["remarks"],
    transactionId: json["transactionId"],
    referenceNumber: json["referenceNumber"],
  );

  Map<String, dynamic> toJson() => {
    "fromAccountNo": fromAccountNo,
    "toAccountNo": toAccountNo,
    "stan": stan,
    // "notificationServiceResponse": notificationServiceResponse!.toJson(),
        "transactionAmount": transactionAmount,
    "transactionStatus": transactionStatus,
    "responseCode": responseCode,
    "transactionCategory": transactionCategory,
    "remarks": remarks,
    "transactionId": transactionId,
    "referenceNumber": referenceNumber,
  };
}

class NotificationServiceResponse {
  String? responseCode;
  String? responseDescription;

  NotificationServiceResponse({
    this.responseCode,
    this.responseDescription,
  });

  factory NotificationServiceResponse.fromJson(Map<String, dynamic> json) => NotificationServiceResponse(
    responseCode: json["responseCode"],
    responseDescription: json["responseDescription"],
  );

  Map<String, dynamic> toJson() => {
    "responseCode": responseCode,
    "responseDescription": responseDescription,
  };
}
