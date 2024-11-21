// To parse this JSON data, do
//
//     final loanRequestsSubmitResponse = loanRequestsSubmitResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

LoanRequestsSubmitResponse loanRequestsSubmitResponseFromJson(String str) => LoanRequestsSubmitResponse.fromJson(json.decode(str));

String loanRequestsSubmitResponseToJson(LoanRequestsSubmitResponse data) => json.encode(data.toJson());

class LoanRequestsSubmitResponse extends Serializable {
  LoanRequestsSubmitResponse({
    this.id,
    this.loanAmount,
    this.monthlyIncome,
    this.status,
    this.createdDate,
  });

  int? id;
  double? loanAmount;
  double? monthlyIncome;
  String? status;
  String? createdDate;

  factory LoanRequestsSubmitResponse.fromJson(Map<String, dynamic> json) => LoanRequestsSubmitResponse(
    id: json["id"],
    loanAmount: json["loanAmount"],
    monthlyIncome: json["monthlyIncome"],
    status: json["status"],
    createdDate: json["createdDate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "loanAmount": loanAmount,
    "monthlyIncome": monthlyIncome,
    "status": status,
    "createdDate": createdDate,
  };
}
