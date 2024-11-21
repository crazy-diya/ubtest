// To parse this JSON data, do
//
//     final updateProfileDetailsRequest = updateProfileDetailsRequestFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

UpdateProfileDetailsRequest updateProfileDetailsRequestFromJson(String str) => UpdateProfileDetailsRequest.fromJson(json.decode(str));

String updateProfileDetailsRequestToJson(UpdateProfileDetailsRequest data) => json.encode(data.toJson());

// ignore: must_be_immutable
class UpdateProfileDetailsRequest extends Equatable {
  String? callingName;
  String? name;
  String messageType;
  String? userName;
  String? mobileNumber;
  String? email;

  UpdateProfileDetailsRequest({
    this.callingName,
    this.name,
    required this.messageType,
    this.userName,
    this.mobileNumber,
    this.email,
  });

  factory UpdateProfileDetailsRequest.fromJson(Map<String, dynamic> json) => UpdateProfileDetailsRequest(
    callingName: json["callingName"],
    name: json["name"],
    messageType: json["messageType"],
    userName: json["userName"],
    mobileNumber: json["mobileNumber"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "callingName": callingName,
    "name": name,
    "messageType": messageType,
    "userName": userName,
    "mobileNumber": mobileNumber,
    "email": email,
  };

  @override
  List<Object?> get props => [callingName,name,messageType,userName,mobileNumber,email];
}
