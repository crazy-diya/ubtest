// To parse this JSON data, do
//
//     final keyExchangeRequest = keyExchangeRequestFromJson(jsonString);

import 'dart:convert';

KeyExchangeRequest keyExchangeRequestFromJson(String str) => KeyExchangeRequest.fromJson(json.decode(str));

String keyExchangeRequestToJson(KeyExchangeRequest data) => json.encode(data.toJson());

class KeyExchangeRequest {
  String? clientPubKey;

  KeyExchangeRequest({
    this.clientPubKey,
  });

  factory KeyExchangeRequest.fromJson(Map<String, dynamic> json) => KeyExchangeRequest(
    clientPubKey: json["clientPubKey"],
  );

  Map<String, dynamic> toJson() => {
    "clientPubKey": clientPubKey,
  };
}
