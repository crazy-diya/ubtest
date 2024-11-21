// To parse this JSON data, do
//
//     final checkUserRequest = checkUserRequestFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

CheckUserRequest checkUserRequestFromJson(String str) => CheckUserRequest.fromJson(json.decode(str));

String checkUserRequestToJson(CheckUserRequest data) => json.encode(data.toJson());

class CheckUserRequest extends Equatable{
    final String? userName;
     final String? messageType;

    CheckUserRequest({
        this.userName,
         this.messageType,
    });

    factory CheckUserRequest.fromJson(Map<String, dynamic> json) => CheckUserRequest(
      messageType: json["messageType"],
        userName: json["userName"],
    );

    Map<String, dynamic> toJson() => {
      "messageType": messageType,
        "userName": userName,
    };
    
      @override
      List<Object?> get props => [userName,messageType];
}
