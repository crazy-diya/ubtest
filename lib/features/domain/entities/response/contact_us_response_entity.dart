// To parse this JSON data, do
//
//     final contactUsResponseModel = contactUsResponseModelFromJson(jsonString);

import 'package:equatable/equatable.dart';

class ContactUsResponseEntity extends Equatable {
  const ContactUsResponseEntity({
    this.data,
  });

  final ContactUsDataEntity? data;

  @override
  List<Object?> get props => [data];
}

class ContactUsDataEntity {
  ContactUsDataEntity({
    this.companyName,
    this.telNo,
    this.email,
    this.busAddLine1,
    this.busAddLine2,
    this.busAddLine3,
  });

  String? companyName;
  String? telNo;
  String? email;
  String? busAddLine1;
  String? busAddLine2;
  String? busAddLine3;
}
