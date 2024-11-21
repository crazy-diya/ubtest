// To parse this JSON data, do
//
//     final addItransferPayRequest = addItransferPayRequestFromJson(jsonString);

import 'dart:convert';

AddItransferPayeeRequest addItransferPayeeRequestFromJson(String str) =>
    AddItransferPayeeRequest.fromJson(json.decode(str));

String addItransferPayRequestToJson(AddItransferPayeeRequest data) =>
    json.encode(data.toJson());

class AddItransferPayeeRequest {
  AddItransferPayeeRequest({
    this.messageType,
    this.name,
    this.nickname,
    this.contact,
    this.addAsFavourite,
    this.email,
  });

  String? messageType;
  String? name;
  String? nickname;
  String? contact;
  bool? addAsFavourite;
  String? email;

  factory AddItransferPayeeRequest.fromJson(Map<String, dynamic> json) =>
      AddItransferPayeeRequest(
        messageType: json["messageType"],
        name: json["name"],
        nickname: json["nickname"],
        contact: json["contact"],
        addAsFavourite: json["addAsFavourite"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "messageType": messageType,
        "name": name,
        "nickname": nickname,
        "contact": contact,
        "addAsFavourite": addAsFavourite,
        "email": email,
      };
}
