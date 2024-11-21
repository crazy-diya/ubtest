// To parse this JSON data, do
//
//     final keyExchangeResponse = keyExchangeResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

KeyExchangeResponse keyExchangeResponseFromJson(String str) => KeyExchangeResponse.fromJson(json.decode(str));

String keyExchangeResponseToJson(KeyExchangeResponse data) => json.encode(data.toJson());

class KeyExchangeResponse extends Serializable {
  String? serverPubKey;

  KeyExchangeResponse({
    this.serverPubKey,
  });

  factory KeyExchangeResponse.fromJson(Map<String, dynamic> json) => KeyExchangeResponse(
    serverPubKey: json["serverPubKey"],
  );

  Map<String, dynamic> toJson() => {
    "serverPubKey": serverPubKey,
  };
}
