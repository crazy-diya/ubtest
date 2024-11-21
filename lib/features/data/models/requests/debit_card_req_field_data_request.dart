// To parse this JSON data, do
//
//     final debitCardReqFieldDataRequest = debitCardReqFieldDataRequestFromJson(jsonString);

import 'dart:convert';

DebitCardReqFieldDataRequest debitCardReqFieldDataRequestFromJson(String str) => DebitCardReqFieldDataRequest.fromJson(json.decode(str));

String debitCardReqFieldDataRequestToJson(DebitCardReqFieldDataRequest data) => json.encode(data.toJson());

class DebitCardReqFieldDataRequest {
  String? messageType;

  DebitCardReqFieldDataRequest({
    this.messageType,
  });

  factory DebitCardReqFieldDataRequest.fromJson(Map<String, dynamic> json) => DebitCardReqFieldDataRequest(
    messageType: json["messageType"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
  };
}
