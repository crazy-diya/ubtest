// To parse this JSON data, do
//
//     final createUserResponse = createUserResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

CreateUserResponse createUserResponseFromJson(String str) =>
    CreateUserResponse.fromJson(json.decode(str));

String createUserResponseToJson(CreateUserResponse data) =>
    json.encode(data.toJson());

class CreateUserResponse extends Serializable {
  final String? epicUserId;

  CreateUserResponse({
    this.epicUserId,
  });

  factory CreateUserResponse.fromJson(Map<String, dynamic> json) =>
      CreateUserResponse(
        epicUserId: json["epicUserId"],
      );

  Map<String, dynamic> toJson() => {
        "epicUserId": epicUserId,
      };
}
