// To parse this JSON data, do
//
//     final leaseReqSaveDataRequest = leaseReqSaveDataRequestFromJson(jsonString);

import 'dart:convert';

LeaseReqSaveDataRequest leaseReqSaveDataRequestFromJson(String str) => LeaseReqSaveDataRequest.fromJson(json.decode(str));

String leaseReqSaveDataRequestToJson(LeaseReqSaveDataRequest data) => json.encode(data.toJson());

class LeaseReqSaveDataRequest {
  LeaseReqSaveDataRequest({
    this.messageType,
    this.title,
    this.firstName,
    this.lastName,
    this.nic,
    this.mobileNo,
    this.addressLine1,
    this.addressLine2,
    this.addressLine3,
    this.gender,
    this.maritalStatus,
    this.employerName,
    this.employeeDesignation,
    this.monthlyIncome,
    this.vehicleType,
    this.makeAndModel,
    this.yearOfManufacture,
    this.regNo,
    this.empType,
    this.imageList,
    this.leaseTypeTenor,
    this.amount,
  });

  String? messageType;
  String? title;
  String? firstName;
  String? lastName;
  String? nic;
  String? mobileNo;
  String? addressLine1;
  String? addressLine2;
  String? addressLine3;
  String? gender;
  String? maritalStatus;
  String? employerName;
  String? employeeDesignation;
  String? monthlyIncome;
  String? vehicleType;
  String? makeAndModel;
  String? yearOfManufacture;
  String? regNo;
  String? empType;
  List<ImageList>? imageList;
  String? leaseTypeTenor;
  String? amount;

  factory LeaseReqSaveDataRequest.fromJson(Map<String, dynamic> json) => LeaseReqSaveDataRequest(
    messageType: json["messageType"],
    title: json["title"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    nic: json["nic"],
    mobileNo: json["mobileNo"],
    addressLine1: json["addressLine1"],
    addressLine2: json["addressLine2"],
    addressLine3: json["addressLine3"],
    gender: json["gender"],
    maritalStatus: json["maritalStatus"],
    employerName: json["employerName"],
    employeeDesignation: json["employeeDesignation"],
    monthlyIncome: json["monthlyIncome"],
    vehicleType: json["vehicleType"],
    makeAndModel: json["makeAndModel"],
    yearOfManufacture: json["yearOfManufacture"],
    regNo: json["regNo"],
    empType: json["empType"],
    imageList: List<ImageList>.from(json["imageList"].map((x) => ImageList.fromJson(x))),
    leaseTypeTenor: json["leaseTypeTenor"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "title": title,
    "firstName": firstName,
    "lastName": lastName,
    "nic": nic,
    "mobileNo": mobileNo,
    "addressLine1": addressLine1,
    "addressLine2": addressLine2,
    "addressLine3": addressLine3,
    "gender": gender,
    "maritalStatus": maritalStatus,
    "employerName": employerName,
    "employeeDesignation": employeeDesignation,
    "monthlyIncome": monthlyIncome,
    "vehicleType": vehicleType,
    "makeAndModel": makeAndModel,
    "yearOfManufacture": yearOfManufacture,
    "regNo": regNo,
    "empType": empType,
    "imageList": List<dynamic>.from(imageList!.map((x) => x.toJson())),
    "leaseTypeTenor": leaseTypeTenor,
    "amount": amount,
  };
}

class ImageList {
  ImageList({
    this.name,
    this.image,
  });

  String? name;
  String? image;

  factory ImageList.fromJson(Map<String, dynamic> json) => ImageList(
    name: json["name"]??"",
    image: json["image"]??"",
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "image": image,
  };
}
