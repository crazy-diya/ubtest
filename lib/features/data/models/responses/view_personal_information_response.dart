// To parse this JSON data, do
//
//     final viewPersonalInformationResponse = viewPersonalInformationResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

ViewPersonalInformationResponse viewPersonalInformationResponseFromJson(
        String str) =>
    ViewPersonalInformationResponse.fromJson(json.decode(str));

String viewPersonalInformationResponseToJson(
        ViewPersonalInformationResponse data) =>
    json.encode(data.toJson());

class ViewPersonalInformationResponse extends Serializable {
  ViewPersonalInformationResponse({
    this.walletId,
    this.userName,
    this.address,
    this.contactNum,
    this.email,
    this.profImage,
  });

  String? walletId;
  String? userName;
  String? address;
  String? contactNum;
  String? email;
  String? profImage;

  factory ViewPersonalInformationResponse.fromJson(Map<String, dynamic> json) =>
      ViewPersonalInformationResponse(
        walletId: json["walletId"],
        userName: json["userName"],
        address: json["address"],
        contactNum: json["contactNum"],
        email: json["email"],
        profImage: json["profImage"],
      );

  Map<String, dynamic> toJson() => {
        "walletId": walletId,
        "userName": userName,
        "address": address,
        "contactNum": contactNum,
        "email": email,
        "profImage": profImage,
      };
}
