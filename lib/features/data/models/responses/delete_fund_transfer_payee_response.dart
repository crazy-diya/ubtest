// To parse this JSON data, do
//
//     final deleteFundTransferPayeeResponse = deleteFundTransferPayeeResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

DeleteFundTransferPayeeResponse deleteFundTransferPayeeResponseFromJson(String str) => DeleteFundTransferPayeeResponse.fromJson(json.decode(str));

String deleteFundTransferPayeeResponseToJson(DeleteFundTransferPayeeResponse data) => json.encode(data.toJson());

class DeleteFundTransferPayeeResponse extends Serializable {
  DeleteFundTransferPayeeResponse({
    this.payeeDataResponseDtoList,
  });

  List<PayeeDataResponseDtoList>? payeeDataResponseDtoList;

  factory DeleteFundTransferPayeeResponse.fromJson(Map<String, dynamic> json) => DeleteFundTransferPayeeResponse(
    payeeDataResponseDtoList: List<PayeeDataResponseDtoList>.from(json["payeeDataResponseDTOList"].map((x) => PayeeDataResponseDtoList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "payeeDataResponseDTOList": List<dynamic>.from(payeeDataResponseDtoList!.map((x) => x.toJson())),
  };
}

class PayeeDataResponseDtoList {
  PayeeDataResponseDtoList({
    this.id,
  });

  int? id;

  factory PayeeDataResponseDtoList.fromJson(Map<String, dynamic> json) => PayeeDataResponseDtoList(
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
  };
}
