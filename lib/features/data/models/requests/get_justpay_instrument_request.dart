// To parse this JSON data, do
//
//     final getJustPayInstrumentRequest = getJustPayInstrumentRequestFromJson(jsonString);

import 'dart:convert';

GetJustPayInstrumentRequest getJustPayInstrumentRequestFromJson(String str) =>
    GetJustPayInstrumentRequest.fromJson(json.decode(str));

String getJustPayInstrumentRequestToJson(
    GetJustPayInstrumentRequest data) =>
    json.encode(data.toJson());

class GetJustPayInstrumentRequest {
  String? messageType;
  String? requestType;

  GetJustPayInstrumentRequest({
     this.messageType,
     this.requestType,
  });

  factory GetJustPayInstrumentRequest.fromJson(Map<String, dynamic> json)
  => GetJustPayInstrumentRequest(
    messageType: json["messageType"],
    requestType: json["requestType"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "requestType": requestType,
  };
}
