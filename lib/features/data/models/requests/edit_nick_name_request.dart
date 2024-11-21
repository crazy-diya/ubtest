// To parse this JSON data, do
//
//     final editNickNamerequest = editNickNamerequestFromJson(jsonString);

import 'dart:convert';

EditNickNamerequest editNickNamerequestFromJson(String str) => EditNickNamerequest.fromJson(json.decode(str));

String editNickNamerequestToJson(EditNickNamerequest data) => json.encode(data.toJson());

class EditNickNamerequest {
  String? messageType;
  int? instrumentId;
  String? nickName;
  String? instrumentType;

  EditNickNamerequest({
     this.messageType,
     this.instrumentId,
     this.nickName,
     this.instrumentType,
  });

  factory EditNickNamerequest.fromJson(Map<String, dynamic> json) => EditNickNamerequest(
    messageType: json["messageType"],
    instrumentId: json["instrumentId"],
    nickName: json["nickName"],
    instrumentType: json["instrumentType"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "instrumentId": instrumentId,
    "nickName": nickName,
    "instrumentType": instrumentType,
  };
}
