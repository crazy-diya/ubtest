// To parse this JSON data, do
//
//     final cityRequest = cityRequestFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

CommonRequest cityRequestFromJson(String str) => CommonRequest.fromJson(json.decode(str));

String cityRequestToJson(CommonRequest data) => json.encode(data.toJson());

class CommonRequest extends Equatable {
  const CommonRequest({
    this.messageType,
    this.appSignature
  });

  final String? messageType;
  final String? appSignature;

  factory CommonRequest.fromJson(Map<String, dynamic> json) => CommonRequest(
        messageType: json["messageType"],
        appSignature: json["appSignature"]
      );

  Map<String, dynamic> toJson() => {
        "messageType": messageType,
        "appSignature":appSignature
      };

  @override
  List<Object?> get props => [messageType,appSignature];
}
