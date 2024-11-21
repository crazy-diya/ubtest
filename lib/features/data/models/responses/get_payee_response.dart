// To parse this JSON data, do
//
//     final getPayeeResponse = getPayeeResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

GetPayeeResponse getPayeeResponseFromJson(String str) =>
    GetPayeeResponse.fromJson(json.decode(str));

String getPayeeResponseToJson(GetPayeeResponse data) => json.encode(data.toJson());

class GetPayeeResponse extends Serializable {
  List<PayeeDataResponseDtoList>? payeeDataResponseDtoList;

  GetPayeeResponse({
    this.payeeDataResponseDtoList,
  });

  factory GetPayeeResponse.fromJson(Map<String, dynamic> json) =>
      GetPayeeResponse(
    payeeDataResponseDtoList: List<PayeeDataResponseDtoList>.from(json["payeeDataResponseDTOList"].map((x) => PayeeDataResponseDtoList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "payeeDataResponseDTOList": List<dynamic>.from(payeeDataResponseDtoList!.map((x) => x.toJson())),
  };
}

class PayeeDataResponseDtoList {
  int? id;
  String? nickName;
  String? epicUserId;
  String? bank;
  String? accountNumber;
  String? name;
  DateTime? createdDate;
  DateTime? modifiedDate;

  PayeeDataResponseDtoList({
    this.id,
    this.nickName,
    this.epicUserId,
    this.bank,
    this.accountNumber,
    this.name,
    this.createdDate,
    this.modifiedDate,
  });

  factory PayeeDataResponseDtoList.fromJson(Map<String, dynamic> json) => PayeeDataResponseDtoList(
    id: json["id"],
    nickName: json["nickName"],
    epicUserId: json["epicUserId"],
    bank: json["bank"],
    accountNumber: json["accountNumber"],
    name: json["name"],
    createdDate: DateTime.parse(json["createdDate"]),
    modifiedDate: DateTime.parse(json["modifiedDate"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nickName": nickName,
    "epicUserId": epicUserId,
    "bank": bank,
    "accountNumber": accountNumber,
    "name": name,
    "createdDate": createdDate!.toIso8601String(),
    "modifiedDate": modifiedDate!.toIso8601String(),
  };
}
