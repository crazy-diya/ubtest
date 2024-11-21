// To parse this JSON data, do
//
//     final creditCardReqSaveResponse = creditCardReqSaveResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

CreditCardReqSaveResponse creditCardReqSaveResponseFromJson(String str) => CreditCardReqSaveResponse.fromJson(json.decode(str));

String creditCardReqSaveResponseToJson(CreditCardReqSaveResponse data) => json.encode(data.toJson());

class CreditCardReqSaveResponse extends Serializable {
  String? referenceNo;

  CreditCardReqSaveResponse({
    this.referenceNo,
  });

  factory CreditCardReqSaveResponse.fromJson(Map<String, dynamic> json) => CreditCardReqSaveResponse(
    referenceNo: json["referenceNo"],
  );

  Map<String, dynamic> toJson() => {
    "referenceNo": referenceNo,
  };
}
