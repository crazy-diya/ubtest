// To parse this JSON data, do
//
//     final contactUsRequestModel = contactUsRequestModelFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

ContactUsRequestModel contactUsRequestModelFromJson(String str) =>
    ContactUsRequestModel.fromJson(json.decode(str));

String contactUsRequestModelToJson(ContactUsRequestModel data) =>
    json.encode(data.toJson());

class ContactUsRequestModel extends Equatable{
  const ContactUsRequestModel({
    this.messageType,
  });

  final String? messageType;

  factory ContactUsRequestModel.fromJson(Map<String, dynamic> json) =>
      ContactUsRequestModel(
        messageType: json["messageType"],
      );

  Map<String, dynamic> toJson() => {
        "messageType": messageType,
      };

  @override
  List<Object?> get props => [messageType];
}
