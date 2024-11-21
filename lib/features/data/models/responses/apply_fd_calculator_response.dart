
import 'dart:convert';

import '../common/base_response.dart';

ApplyFdCalculatorResponse applyFdCalculatorResponseFromJson(String str) => ApplyFdCalculatorResponse.fromJson(json.decode(str));

String applyFdCalculatorResponseToJson(ApplyFdCalculatorResponse data) => json.encode(data.toJson());

class ApplyFdCalculatorResponse extends Serializable{
  String? responseCode;
  String? responseDescription;

  ApplyFdCalculatorResponse({
    this.responseCode,
    this.responseDescription,
  });

  factory ApplyFdCalculatorResponse.fromJson(Map<String, dynamic> json) => ApplyFdCalculatorResponse(
    responseCode: json["responseCode"],
    responseDescription: json["responseDescription"],
  );

  Map<String, dynamic> toJson() => {
    "responseCode": responseCode,
    "responseDescription": responseDescription,
  };
}

