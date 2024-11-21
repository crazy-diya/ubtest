// To parse this JSON data, do
//
//     final addItransferPayeeResponse = addItransferPayeeResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

AddItransferPayeeResponse addItransferPayeeResponseFromJson(String str) => AddItransferPayeeResponse.fromJson(json.decode(str));

String addItransferPayeeResponseToJson(AddItransferPayeeResponse data) => json.encode(data.toJson());

class AddItransferPayeeResponse extends Serializable {
  AddItransferPayeeResponse({
    this.id,
    this.name,
    this.nickName,
    this.contact,
    this.favourite,
    this.epicUserId,
    this.email,
  });

  int? id;
  String? name;
  String? nickName;
  String? contact;
  bool? favourite;
  String? epicUserId;
  String? email;

  factory AddItransferPayeeResponse.fromJson(Map<String, dynamic> json) => AddItransferPayeeResponse(
    id: json["id"],
    name: json["name"],
    nickName: json["nickName"],
    contact: json["contact"],
    favourite: json["favourite"],
    epicUserId: json["epicUserId"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "nickName": nickName,
    "contact": contact,
    "favourite": favourite,
    "epicUserId": epicUserId,
    "email": email,
  };
}
