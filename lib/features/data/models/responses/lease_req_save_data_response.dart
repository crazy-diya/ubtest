// To parse this JSON data, do
//
//     final leaseReqSaveDataResponse = leaseReqSaveDataResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

LeaseReqSaveDataResponse leaseReqSaveDataResponseFromJson(String str) => LeaseReqSaveDataResponse.fromJson(json.decode(str));

String leaseReqSaveDataResponseToJson(LeaseReqSaveDataResponse data) => json.encode(data.toJson());

class LeaseReqSaveDataResponse extends Serializable {
  LeaseReqSaveDataResponse({
    this.id,
    this.employerName,
    this.monthlyIncome,
    this.vehicleType,
    this.makeAndModel,
    this.yearOfManufacture,
    this.regNo,
    this.status,
    this.createdDate,
  });

  int? id;
  String? employerName;
  double? monthlyIncome;
  String? vehicleType;
  String? makeAndModel;
  String? yearOfManufacture;
  String? regNo;
  String? status;
  DateTime? createdDate;

  factory LeaseReqSaveDataResponse.fromJson(Map<String, dynamic> json) => LeaseReqSaveDataResponse(
    id: json["id"],
    employerName: json["employerName"],
    monthlyIncome: json["monthlyIncome"],
    vehicleType: json["vehicleType"],
    makeAndModel: json["makeAndModel"],
    yearOfManufacture: json["yearOfManufacture"],
    regNo: json["regNo"],
    status: json["status"],
    createdDate: DateTime.parse(json["createdDate"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "employerName": employerName,
    "monthlyIncome": monthlyIncome,
    "vehicleType": vehicleType,
    "makeAndModel": makeAndModel,
    "yearOfManufacture": yearOfManufacture,
    "regNo": regNo,
    "status": status,
    "createdDate": createdDate!.toIso8601String(),
  };
}
