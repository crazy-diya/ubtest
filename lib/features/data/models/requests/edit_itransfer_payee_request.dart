// To parse this JSON data, do
//
//     final editItransferPayeeRequest = editItransferPayeeRequestFromJson(jsonString);

import 'dart:convert';

EditItransferPayeeRequest editItransferPayeeRequestFromJson(String str) => EditItransferPayeeRequest.fromJson(json.decode(str));

String editItransferPayeeRequestToJson(EditItransferPayeeRequest data) => json.encode(data.toJson());

class EditItransferPayeeRequest {
  EditItransferPayeeRequest({
    this.messageType,
    this.id,
    this.name,
    this.nickname,
    this.contact,
    this.addAsFavourite,
  });

  String? messageType;
  int? id;
  String? name;
  String? nickname;
  String? contact;
  bool? addAsFavourite;

  factory EditItransferPayeeRequest.fromJson(Map<String, dynamic> json) => EditItransferPayeeRequest(
    messageType: json["messageType"],
    id: json["id"],
    name: json["name"],
    nickname: json["nickname"],
    contact: json["contact"],
    addAsFavourite: json["addAsFavourite"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "id": id,
    "name": name,
    "nickname": nickname,
    "contact": contact,
    "addAsFavourite": addAsFavourite,
  };
}
