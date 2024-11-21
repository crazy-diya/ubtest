
import 'dart:convert';

import '../common/base_response.dart';

FundTransferPayeeListResponse payeeListResponseFromJson(String str) => FundTransferPayeeListResponse.fromJson(json.decode(str));

String payeeListResponseToJson(FundTransferPayeeListResponse data) => json.encode(data.toJson());

class FundTransferPayeeListResponse extends Serializable {
  FundTransferPayeeListResponse({
    this.payeeDataResponseDtoList,
  });

  List<PayeeResponseData>? payeeDataResponseDtoList;

  factory FundTransferPayeeListResponse.fromJson(Map<String, dynamic> json) =>
      FundTransferPayeeListResponse(
    payeeDataResponseDtoList:json["payeeDataResponseDTOList"]== null ? [] :
    List<PayeeResponseData>.from(json["payeeDataResponseDTOList"].map((x) =>
        PayeeResponseData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "payeeDataResponseDTOList": List<dynamic>.from(payeeDataResponseDtoList!.map((x) => x.toJson())),
  };
}

class PayeeResponseData {
  PayeeResponseData({
    this.id,
    this.nickName,
    this.epicUserId,
    this.bank,
    this.accountNumber,
    this.name,
    this.favourite,
    this.createdDate,
    this.modifiedDate,
    this.branchName,
    this.branchCode,
    this.bankCode,
   this.ceftCode,

  });

  int? id;
  String? nickName;
  String? epicUserId;
  String? bank;
  String? ceftCode;
  String? accountNumber;
  String? name;
  String? bankCode;
  String? branchName;
  String? branchCode;
  bool? favourite;
  DateTime? createdDate;
  DateTime? modifiedDate;

  factory PayeeResponseData.fromJson(Map<String, dynamic> json) =>
      PayeeResponseData(
    id: json["id"],
    nickName: json["nickName"],
    epicUserId: json["epicUserId"],
    bank: json["bankName"],
    accountNumber: json["accountNumber"],
    name: json["name"],
    bankCode: json["bankCode"],
    branchName: json["branchName"],
    branchCode: json["branchCode"],
    favourite: json["favourite"],
    ceftCode: json["ceftCode"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nickName": nickName,
    "epicUserId": epicUserId,
    "bankName": bank,
    "branchName": branchName,
    "accountNumber": accountNumber,
    "ceftCode": ceftCode,
    "name": name,
    "bankCode": bankCode,
    "branchCode": branchCode,
    "favourite": favourite,
    "createdDate": createdDate!.toIso8601String(),
    "modifiedDate": modifiedDate!.toIso8601String(),
  };
}
