// To parse this JSON data, do
//
//     final applyPersonalLoanResponse = applyPersonalLoanResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

ApplyPersonalLoanResponse applyPersonalLoanResponseFromJson(String str) => ApplyPersonalLoanResponse.fromJson(json.decode(str));

String applyPersonalLoanResponseToJson(ApplyPersonalLoanResponse data) => json.encode(data.toJson());

class ApplyPersonalLoanResponse extends Serializable{
  String? responseCode;
  String? responseDescription;

  ApplyPersonalLoanResponse({
    this.responseCode,
    this.responseDescription,
  });

  factory ApplyPersonalLoanResponse.fromJson(Map<String, dynamic> json) => ApplyPersonalLoanResponse(
    responseCode: json["responseCode"],
    responseDescription: json["responseDescription"],
  );

  Map<String, dynamic> toJson() => {
    "responseCode": responseCode,
    "responseDescription": responseDescription,
  };
}
