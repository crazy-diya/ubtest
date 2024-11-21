// To parse this JSON data, do
//
//     final srServiceChargeResponse = srServiceChargeResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

SrServiceChargeResponse srServiceChargeResponseFromJson(String str) => SrServiceChargeResponse.fromJson(json.decode(str));

String srServiceChargeResponseToJson(SrServiceChargeResponse data) => json.encode(data.toJson());

class SrServiceChargeResponse extends Serializable {
  final List<ServiceCharge>? data;

  SrServiceChargeResponse({
    this.data,
  });

  factory SrServiceChargeResponse.fromJson(Map<String, dynamic> json) => SrServiceChargeResponse(
    data: json["data"] == null ? [] : List<ServiceCharge>.from(json["data"]!.map((x) => ServiceCharge.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ServiceCharge {
  final String? transactiontype;
  final int? charge;

  ServiceCharge({
    this.transactiontype,
    this.charge,
  });

  factory ServiceCharge.fromJson(Map<String, dynamic> json) => ServiceCharge(
    transactiontype: json["transactiontype"],
    charge: json["charge"],
  );

  Map<String, dynamic> toJson() => {
    "transactiontype": transactiontype,
    "charge": charge,
  };
}
