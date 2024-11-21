// To parse this JSON data, do
//
//     final createUserRequest = createUserRequestFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

CreateUserRequest createUserRequestFromJson(String str) =>
    CreateUserRequest.fromJson(json.decode(str));

String createUserRequestToJson(CreateUserRequest data) =>
    json.encode(data.toJson());

class CreateUserRequest extends Equatable {
  const CreateUserRequest({
    this.messageType,
    this.username,
    this.password,
    this.confirmPassword,
    this.onBoardedType,
  });

  final String? messageType;
  final String? username;
  final String? password;
  final String? confirmPassword;
  final String? onBoardedType;

  factory CreateUserRequest.fromJson(Map<String, dynamic> json) =>
      CreateUserRequest(
        messageType: json["messageType"],
        username: json["username"],
        password: json["password"],
        confirmPassword: json["confirmPassword"],
        onBoardedType: json["onBoardedType"],
      );

  Map<String, dynamic> toJson() => {
        "messageType": messageType,
        "username": username,
        "password": password,
        "confirmPassword": confirmPassword,
        "onBoardedType": onBoardedType,
      };

  @override
  List<Object?> get props => [messageType, username, password, confirmPassword];
}
