// To parse this JSON data, do
//
//     final faqRequest = faqRequestFromJson(jsonString);

import 'dart:convert';

FaqRequest faqRequestFromJson(String str) => FaqRequest.fromJson(json.decode(str));

String faqRequestToJson(FaqRequest data) => json.encode(data.toJson());

class FaqRequest  {
  FaqRequest({
    this.messageType,
  });

  String? messageType;


  factory FaqRequest.fromJson(Map<String, dynamic> json) => FaqRequest(
    messageType: json["messageType"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
  };
}
