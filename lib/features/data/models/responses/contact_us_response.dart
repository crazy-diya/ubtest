// To parse this JSON data, do
//
//     final contactUsResponseModel = contactUsResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

ContactUsResponseModel contactUsResponseModelFromJson(String str) => ContactUsResponseModel.fromJson(json.decode(str));

String contactUsResponseModelToJson(ContactUsResponseModel data) => json.encode(data.toJson());

class ContactUsResponseModel extends Serializable{
  List<ContactUsDetail>? contactUsDetails;

  ContactUsResponseModel({
    this.contactUsDetails,
  });

  factory ContactUsResponseModel.fromJson(Map<String, dynamic> json) => ContactUsResponseModel(
    contactUsDetails: json["contactUsDetails"] == null ? [] : List<ContactUsDetail>.from(json["contactUsDetails"]!.map((x) => ContactUsDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "contactUsDetails": contactUsDetails == null ? [] : List<dynamic>.from(contactUsDetails!.map((x) => x.toJson())),
  };
}

class ContactUsDetail {
  String? code;
  String? description;
  String? value;

  ContactUsDetail({
    this.code,
    this.description,
    this.value,
  });

  factory ContactUsDetail.fromJson(Map<String, dynamic> json) => ContactUsDetail(
    code: json["code"],
    description: json["description"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "description": description,
    "value": value,
  };
}
