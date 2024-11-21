// To parse this JSON data, do
//
//     final mobileLoginRequest = mobileLoginRequestFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class TemporaryLoginRequest extends Equatable {
  TemporaryLoginRequest({
    this.username,
    this.password,
    this.messageType,
  });

  String? username;
  String? password;
  String? messageType;

  factory TemporaryLoginRequest.fromRawJson(String str) => TemporaryLoginRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TemporaryLoginRequest.fromJson(Map<String, dynamic> json) => TemporaryLoginRequest(
    username: json["username"],
    password: json["password"],
    messageType: json["messageType"], 
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,
    "messageType": messageType,
  };
  
  @override
  List<Object?> get props => [username,password,messageType];
}
