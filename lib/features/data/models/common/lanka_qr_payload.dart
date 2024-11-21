// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final lankaQrPayload = lankaQrPayloadFromJson(jsonString);

import 'dart:convert';

class LankaQrPayload {

    String? qrMaiData;
  String? referenceId;
  String? transactionFee;
  String? convenienceFee;
  double? conveniencePercentage;
  String? tipOrConFeeIndicator;
  String? merchantName;
  String? merchantCity;
  String? terminalId;
  String? billNumber;
  String? mobileNumber;
  String? storeId;
  String? loyaltyNumber;
  String? unrestrictedTag85String;
  String? pointOfInitiationMethod;
  String? merchantCategoryCode;
  LankaQrPayload({
    this.qrMaiData,
    this.referenceId,
    this.transactionFee,
    this.convenienceFee,
    this.conveniencePercentage,
    this.tipOrConFeeIndicator,
    this.merchantName,
    this.merchantCity,
    this.terminalId,
    this.billNumber,
    this.mobileNumber,
    this.storeId,
    this.loyaltyNumber,
    this.unrestrictedTag85String,
    this.pointOfInitiationMethod,
    this.merchantCategoryCode,
  });



  factory LankaQrPayload.fromRawJson(String str) => LankaQrPayload.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LankaQrPayload.fromJson(Map<String, dynamic> json) => LankaQrPayload(
    qrMaiData: json["qrMAIData"],
    referenceId: json["referenceId"],
    transactionFee: json["transactionFee"],
    convenienceFee: json["convenienceFee"],
    conveniencePercentage: json["conveniencePercentage"].toDouble(),
    tipOrConFeeIndicator: json["tipOrConFeeIndicator"],
    merchantName: json["merchantName"],
    merchantCity: json["merchantCity"],
    terminalId: json["terminalId"],
    billNumber: json["billNumber"],
    mobileNumber: json["mobileNumber"],
    storeId: json["storeId"],
    loyaltyNumber: json["loyaltyNumber"],
    unrestrictedTag85String: json["unrestrictedTag85String"],
    pointOfInitiationMethod: json["pointOfInitiationMethod"],
    merchantCategoryCode: json["merchantCategoryCode"],
  );

  Map<String, dynamic> toJson() => {
    "qrMAIData": qrMaiData,
    "referenceId": referenceId,
    "transactionFee": transactionFee,
    "convenienceFee": convenienceFee,
    "conveniencePercentage": conveniencePercentage,
    "tipOrConFeeIndicator": tipOrConFeeIndicator,
    "merchantName": merchantName,
    "merchantCity": merchantCity,
    "terminalId": terminalId,
    "billNumber": billNumber,
    "mobileNumber": mobileNumber,
    "storeId": storeId,
    "loyaltyNumber": loyaltyNumber,
    "unrestrictedTag85String": unrestrictedTag85String,
    "pointOfInitiationMethod": pointOfInitiationMethod,
    "merchantCategoryCode": merchantCategoryCode,
  };

  @override
  String toString() {
    return 'LankaQrPayload(qrMaiData: $qrMaiData, referenceId: $referenceId, transactionFee: $transactionFee, convenienceFee: $convenienceFee, conveniencePercentage: $conveniencePercentage, tipOrConFeeIndicator: $tipOrConFeeIndicator, merchantName: $merchantName, merchantCity: $merchantCity, terminalId: $terminalId, billNumber: $billNumber, mobileNumber: $mobileNumber, storeId: $storeId, loyaltyNumber: $loyaltyNumber, unrestrictedTag85String: $unrestrictedTag85String, pointOfInitiationMethod: $pointOfInitiationMethod, merchantCategoryCode: $merchantCategoryCode)';
  }
}
