// To parse this JSON data, do
//
//     final loanRequestsSubmitRequest = loanRequestsSubmitRequestFromJson(jsonString);

import 'dart:convert';

LoanRequestsSubmitRequest loanRequestsSubmitRequestFromJson(String str) => LoanRequestsSubmitRequest.fromJson(json.decode(str));

String loanRequestsSubmitRequestToJson(LoanRequestsSubmitRequest data) => json.encode(data.toJson());

class LoanRequestsSubmitRequest {
  LoanRequestsSubmitRequest({
    this.messageType,
    this.loanTypeTenor,
    this.loanAmount,
    this.monthlyIncome,
    this.title,
    this.firstName,
    this.lastName,
    this.nic,
    this.mobileNo,
    this.addressLine1,
    this.addressLine2,
    this.addressLine3,
    this.empType,
    this.maritalStatus,
    this.gender,
    this.company,
    this.imageList,
  });

  String? messageType;
  String? loanTypeTenor;
  String? loanAmount;
  String? monthlyIncome;
  String? title;
  String? firstName;
  String? lastName;
  String? nic;
  String? mobileNo;
  String? addressLine1;
  String? addressLine2;
  String? addressLine3;
  String? empType;
  String? maritalStatus;
  String? gender;
  String? company;
  List<ImageListLoan>? imageList;

  factory LoanRequestsSubmitRequest.fromJson(Map<String, dynamic> json) => LoanRequestsSubmitRequest(
    messageType: json["messageType"],
    loanTypeTenor: json["loanTypeTenor"],
    loanAmount: json["loanAmount"],
    monthlyIncome: json["monthlyIncome"],
    title: json["title"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    nic: json["nic"],
    mobileNo: json["mobileNo"],
    addressLine1: json["addressLine1"],
    addressLine2: json["addressLine2"],
    addressLine3: json["addressLine3"],
    empType: json["empType"],
    maritalStatus: json["maritalStatus"],
    gender: json["gender"],
    company: json["company"],
    imageList: List<ImageListLoan>.from(json["imageList"].map((x) => ImageListLoan.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "loanTypeTenor": loanTypeTenor,
    "loanAmount": loanAmount,
    "monthlyIncome": monthlyIncome,
    "title": title,
    "firstName": firstName,
    "lastName": lastName,
    "nic": nic,
    "mobileNo": mobileNo,
    "addressLine1": addressLine1,
    "addressLine2": addressLine2,
    "addressLine3": addressLine3,
    "empType": empType,
    "maritalStatus": maritalStatus,
    "gender": gender,
    "company": company,
    "imageList": List<dynamic>.from(imageList!.map((x) => x.toJson())),
  };
}

class ImageListLoan {
  ImageListLoan({
    this.name,
    this.image,
  });

  String? name;
  String? image;

  factory ImageListLoan.fromJson(Map<String, dynamic> json) => ImageListLoan(
    name: json["name"]??"",
    image: json["image"]??"",
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "image": image,
  };
}
