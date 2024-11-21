// To parse this JSON data, do
//
//     final addJustPayInstrumentsRequest = addJustPayInstrumentsRequestFromJson(jsonString);

import 'dart:convert';

AddJustPayInstrumentsRequest addJustPayInstrumentsRequestFromJson(String str) =>
    AddJustPayInstrumentsRequest.fromJson(json.decode(str));

String addJustPayInstrumentsRequestToJson(AddJustPayInstrumentsRequest data) =>
    json.encode(data.toJson());

class AddJustPayInstrumentsRequest {
  AddJustPayInstrumentsRequest({
    this.messageType,
  });

  String? messageType;

  factory AddJustPayInstrumentsRequest.fromJson(Map<String, dynamic> json) =>
      AddJustPayInstrumentsRequest(
        messageType: json["messageType"],
      );

  Map<String, dynamic> toJson() => {
        "messageType": messageType,
      };
}
