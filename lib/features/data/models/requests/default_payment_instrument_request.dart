// To parse this JSON data, do
//
//     final defaultPaymentInstrumentRequest = defaultPaymentInstrumentRequestFromJson(jsonString);

import 'dart:convert';

DefaultPaymentInstrumentRequest defaultPaymentInstrumentRequestFromJson(String str) => DefaultPaymentInstrumentRequest.fromJson(json.decode(str));

String defaultPaymentInstrumentRequestToJson(DefaultPaymentInstrumentRequest data) => json.encode(data.toJson());

class DefaultPaymentInstrumentRequest {
  DefaultPaymentInstrumentRequest({
    this.messageType,
    this.instrumentId,
  });

  String? messageType;
  int? instrumentId;

  factory DefaultPaymentInstrumentRequest.fromJson(Map<String, dynamic> json) => DefaultPaymentInstrumentRequest(
    messageType: json["messageType"],
    instrumentId: json["instrumentId"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "instrumentId": instrumentId,
  };
}
