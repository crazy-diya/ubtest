// To parse this JSON data, do
//
//     final oneTimeFundTransferResponse = oneTimeFundTransferResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

OneTimeFundTransferResponse oneTimeFundTransferResponseFromJson(String str) => OneTimeFundTransferResponse.fromJson(json.decode(str));

String oneTimeFundTransferResponseToJson(OneTimeFundTransferResponse data) => json.encode(data.toJson());

class OneTimeFundTransferResponse extends Serializable{
  OneTimeFundTransferResponse({
    this.messageType,
  });

  String? messageType;

  factory OneTimeFundTransferResponse.fromJson(Map<String, dynamic> json) => OneTimeFundTransferResponse(
    messageType: json["messageType"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
  };
}
