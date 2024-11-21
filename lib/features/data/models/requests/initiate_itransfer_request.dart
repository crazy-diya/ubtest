// To parse this JSON data, do
//
//     final initiateItransfertRequest = initiateItransfertRequestFromJson(jsonString);

import 'dart:convert';

InitiateItransfertRequest initiateItransfertRequestFromJson(String str) => InitiateItransfertRequest.fromJson(json.decode(str));

String initiateItransfertRequestToJson(InitiateItransfertRequest data) => json.encode(data.toJson());

class InitiateItransfertRequest {
  String? messageType;
  String? themeId;
  String? amount;
  String? receiverName;
  String? mobile;
  String? email;
  String? message;
  bool? anonymous;
  String? paymentInstrument;

  InitiateItransfertRequest({
    this.messageType,
    this.themeId,
    this.amount,
    this.receiverName,
    this.mobile,
    this.email,
    this.message,
    this.anonymous,
    this.paymentInstrument,
  });

  factory InitiateItransfertRequest.fromJson(Map<String, dynamic> json) => InitiateItransfertRequest(
    messageType: json["messageType"],
    themeId: json["themeId"],
    amount: json["amount"],
    receiverName: json["receiverName"],
    mobile: json["mobile"],
    email: json["email"],
    message: json["message"],
    anonymous: json["anonymous"],
    paymentInstrument: json["paymentInstrument"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "themeId": themeId,
    "amount": amount,
    "receiverName": receiverName,
    "mobile": mobile,
    "email": email,
    "message": message,
    "anonymous": anonymous,
    "paymentInstrument": paymentInstrument,
  };
}
