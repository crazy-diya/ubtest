// To parse this JSON data, do
//
//     final applyHousingLoanResponse = applyHousingLoanResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

ApplyHousingLoanResponse applyHousingLoanResponseFromJson(String str) => ApplyHousingLoanResponse.fromJson(json.decode(str));

String applyHousingLoanResponseToJson(ApplyHousingLoanResponse data) => json.encode(data.toJson());

class ApplyHousingLoanResponse extends Serializable {
  String? responseCode;

  ApplyHousingLoanResponse({
    this.responseCode,
  });

  factory ApplyHousingLoanResponse.fromJson(Map<String, dynamic> json) => ApplyHousingLoanResponse(
    responseCode: json["responseCode"],
  );

  Map<String, dynamic> toJson() => {
    "responseCode": responseCode,
  };
}
