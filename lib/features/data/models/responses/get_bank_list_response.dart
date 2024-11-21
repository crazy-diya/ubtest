// To parse this JSON data, do
//
//     final accountInquiryResponse = accountInquiryResponseFromJson(jsonString);


import '../common/base_response.dart';

class GetBankListResponse extends Serializable {
  GetBankListResponse({
    this.banks,
  });

  List<Bank>? banks;

  factory GetBankListResponse.fromJson(Map<String, dynamic> json) => GetBankListResponse(
    banks: List<Bank>.from(json["data"].map((x) => Bank.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(banks!.map((x) => x.toJson())),
  };
}

class Bank {
  Bank({
    this.code,
    this.description,
  });

  String? code;
  String? description;

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
    code: json["bankCode"],
    description: json["bankName"],
  );

  Map<String, dynamic> toJson() => {
    "bankCode": code,
    "bankName": description,
  };
}
