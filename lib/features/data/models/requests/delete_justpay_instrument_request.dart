

import 'dart:convert';

DeleteJustPayInstrumentRequest
deleteJustPayInstrumentRequestFromJson(String str) =>
    DeleteJustPayInstrumentRequest.fromJson(json.decode(str));

String deleteJustPayInstrumentRequestToJson
    (DeleteJustPayInstrumentRequest data) =>
    json.encode(data.toJson());

class DeleteJustPayInstrumentRequest {
  int? instrumentId;
  String? instrumentType;
  String? messageType;

  DeleteJustPayInstrumentRequest({
    required this.messageType,
    required this.instrumentId,
    required this.instrumentType,
  });

  factory DeleteJustPayInstrumentRequest.fromJson(Map<String, dynamic> json) =>
      DeleteJustPayInstrumentRequest(
        messageType: json["messageType"],
    instrumentId: json["instrumentId"],
    instrumentType: json["instrumentType"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "instrumentId": instrumentId,
    "instrumentType": instrumentType,
  };
}
