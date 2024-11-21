import 'dart:convert';

ChequeBookRequest chequeBookRequestFromJson(String str) =>
    ChequeBookRequest.fromJson(json.decode(str));

String chequeBookRequestToJson(ChequeBookRequest data) =>
    json.encode(data.toJson());

class ChequeBookRequest {
  String? accountNumber;
  String? collectionMethod;
  String? branch;
  String? address;
  String? serviceCharge;
  int? numberOfLeaves;

  ChequeBookRequest({
    this.accountNumber,
    this.collectionMethod,
    this.branch,
    this.address,
    this.serviceCharge,
    this.numberOfLeaves,
  });

  factory ChequeBookRequest.fromJson(Map<String, dynamic> json) =>
      ChequeBookRequest(
        accountNumber: json["accountNumber"],
        collectionMethod: json["collectionMethod"],
        branch: json["branch"],
        address: json["address"],
        serviceCharge: json["serviceCharge"],
        numberOfLeaves: json["numberOfLeaves"],
      );

  Map<String, dynamic> toJson() => {
        "accountNumber": accountNumber,
        "collectionMethod": collectionMethod,
        "branch": branch,
        "address": address,
        "serviceCharge": serviceCharge,
        "numberOfLeaves": numberOfLeaves,
      };
}
