// To parse this JSON data, do
//
//     final creditCardReqFieldDataRequest = creditCardReqFieldDataRequestFromJson(jsonString);

import 'dart:convert';

CreditCardReqFieldDataRequest creditCardReqFieldDataRequestFromJson(String str) => CreditCardReqFieldDataRequest.fromJson(json.decode(str));

String creditCardReqFieldDataRequestToJson(CreditCardReqFieldDataRequest data) => json.encode(data.toJson());

class CreditCardReqFieldDataRequest {
  CreditCardReqFieldDataRequest({
    this.messageType,
  });

  String? messageType;

  factory CreditCardReqFieldDataRequest.fromJson(Map<String, dynamic> json) => CreditCardReqFieldDataRequest(
    messageType: json["messageType"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
  };
}
