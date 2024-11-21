import 'dart:convert';

import 'package:equatable/equatable.dart';

CustomerRegistrationRequest customerRegistrationRequestFromJson(String str) =>
    CustomerRegistrationRequest.fromJson(json.decode(str));

String customerRegistrationRequestToJson(CustomerRegistrationRequest data) =>
    json.encode(data.toJson());

// ignore: must_be_immutable
class CustomerRegistrationRequest extends Equatable {
  CustomerRegistrationRequest({
    this.messageType,
    this.title,
    this.initials,
    this.initialsInFull,
    this.lastName,
    this.nationality,
    this.gender,
    this.language,
    this.religion,
    this.nic,
    this.dateOfBirth,
    this.mobileNo,
    this.email,
    this.perAddress,
    this.maritalStatus,
    this.obType,
  });

  String? messageType;
  String? title;
  String? initials;
  String? initialsInFull;
  String? lastName;
  String? nationality;
  String? gender;
  String? language;
  String? religion;
  String? nic;
  String? dateOfBirth;
  String? mobileNo;
  String? email;
  String? maritalStatus;
  String? obType;
  List<PerAddress>? perAddress;

  factory CustomerRegistrationRequest.fromJson(Map<String, dynamic> json) =>
      CustomerRegistrationRequest(
        messageType: json["messageType"],
        obType: json["obType"],
        title: json["title"],
        initials: json["initials"],
        initialsInFull: json["initialsInFull"],
        lastName: json["lastName"],
        nationality: json["nationality"],
        gender: json["gender"],
        language: json["language"],
        religion: json["religion"],
        nic: json["nic"],
        dateOfBirth: json["dateOfBirth"],
        mobileNo: json["mobileNo"],
        email: json["email"],
        maritalStatus: json["maritalStatus"],
        perAddress: json["perAddress"] != null
            ? List<PerAddress>.from(
                json["perAddress"].map((x) => PerAddress.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "messageType": messageType,
        "obType": obType,
        "title": title,
        "initials": initials,
        "initialsInFull": initialsInFull,
        "lastName": lastName,
        "nationality": nationality,
        "gender": gender,
        "language": language,
        "religion": religion,
        "nic": nic,
        "dateOfBirth": dateOfBirth,
        "mobileNo": mobileNo,
        "email": email,
        "maritalStatus": maritalStatus,
        "perAddress": perAddress != null
            ? List<dynamic>.from(perAddress!.map((x) => x.toJson()))
            : null,
      };

  @override
  List<Object?> get props => [
        messageType,
        obType,
        title,
        initials,
        initialsInFull,
        lastName,
        nationality,
        gender,
        language,
        religion,
        nic,
        dateOfBirth,
        mobileNo,
        email,
        maritalStatus,
        perAddress,
      ];
}

class PerAddress {
  PerAddress({
    this.addressLine1,
    this.addressLine2,
    this.addressLine3,
    this.city,
    this.cityUiValue,
    this.equalityWithNic,
  });

  String? addressLine1;
  String? addressLine2;
  String? addressLine3;
  int? city;
  String? cityUiValue;
  bool? equalityWithNic;

  factory PerAddress.fromJson(Map<String, dynamic> json) => PerAddress(
        addressLine1: json["addressLine1"],
        addressLine2: json["addressLine2"],
        addressLine3: json["addressLine3"],
        cityUiValue: json["cityUiValue"],
        city: json["city"],
        equalityWithNic: json["equalityWithNic"],
      );

  Map<String, dynamic> toJson() => {
        "addressLine1": addressLine1,
        "addressLine2": addressLine2,
        "addressLine3": addressLine3,
        "cityUiValue": cityUiValue,
        "city": city,
        "equalityWithNic": equalityWithNic,
      };
}
