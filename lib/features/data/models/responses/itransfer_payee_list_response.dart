// // To parse this JSON data, do
// //
// //     final itransferPayeeListResponse = itransferPayeeListResponseFromJson(jsonString);
//
// import 'dart:convert';
//
// import '../common/base_response.dart';
//
// ItransferPayeeListResponse itransferPayeeListResponseFromJson(String str) =>
//     ItransferPayeeListResponse.fromJson(json.decode(str));
//
// String itransferPayeeListResponseToJson(ItransferPayeeListResponse data) =>
//     json.encode(data.toJson());
//
// class ItransferPayeeListResponse extends Serializable {
//   ItransferPayeeListResponse({
//     this.getPayeesResponseDTOList,
//   });
//
//   List<GetPayeeResponseDtoList>? getPayeesResponseDTOList;
//
//   factory ItransferPayeeListResponse.fromJson(Map<String, dynamic> json) =>
//       ItransferPayeeListResponse(
//         getPayeesResponseDTOList: json["getPayeesResponseDTOList"] != null
//             ? List<GetPayeeResponseDtoList>.from(
//                 json["getPayeesResponseDTOList"]
//                     .map((x) => GetPayeeResponseDtoList.fromJson(x)))
//             : List.empty(),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "getPayeesResponseDTOList":
//             List<dynamic>.from(getPayeesResponseDTOList!.map((x) => x.toJson())),
//       };
// }
//
// class GetPayeeResponseDtoList {
//   GetPayeeResponseDtoList({
//     this.id,
//     this.name,
//     this.nickName,
//     this.contact,
//     this.email,
//     this.favourite,
//     this.epicUserId,
//   });
//
//   int? id;
//   String? name;
//   String? nickName;
//   String? contact;
//   String? email;
//   bool? favourite;
//   String? epicUserId;
//
//   factory GetPayeeResponseDtoList.fromJson(Map<String, dynamic> json) =>
//       GetPayeeResponseDtoList(
//         id: json["id"],
//         name: json["name"],
//         nickName: json["nickName"],
//         contact: json["contact"],
//         email: json["email"],
//         favourite: json["favourite"],
//         epicUserId: json["epicUserId"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "nickName": nickName,
//         "contact": contact,
//         "email": email,
//         "favourite": favourite,
//         "epicUserId": epicUserId,
//       };
// }


// To parse this JSON data, do
//
//     final itransferPayeeListResponse = itransferPayeeListResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

ItransferPayeeListResponse itransferPayeeListResponseFromJson(String str) => ItransferPayeeListResponse.fromJson(json.decode(str));

String itransferPayeeListResponseToJson(ItransferPayeeListResponse data) => json.encode(data.toJson());

class ItransferPayeeListResponse extends Serializable {
  List<PayeeDataResponseDtoList>? payeeDataResponseDtoList;

  ItransferPayeeListResponse({
    this.payeeDataResponseDtoList,
  });

  factory ItransferPayeeListResponse.fromJson(Map<String, dynamic> json) => ItransferPayeeListResponse(
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
  String? bankCode;
  String? ceftCode;
  String? bankName;
  String? accountNumber;
  String? name;
  bool? favourite;
  DateTime? createdDate;
  DateTime? modifiedDate;

  PayeeDataResponseDtoList({
    this.id,
    this.nickName,
    this.epicUserId,
    this.bankCode,
    this.ceftCode,
    this.bankName,
    this.accountNumber,
    this.name,
    this.favourite,
    this.createdDate,
    this.modifiedDate,
  });

  factory PayeeDataResponseDtoList.fromJson(Map<String, dynamic> json) => PayeeDataResponseDtoList(
    id: json["id"],
    nickName: json["nickName"],
    epicUserId: json["epicUserId"],
    bankCode: json["bankCode"],
    ceftCode: json["ceftCode"],
    bankName: json["bankName"],
    accountNumber: json["accountNumber"],
    name: json["name"],
    favourite: json["favourite"],
    createdDate: DateTime.parse(json["createdDate"]),
    modifiedDate: DateTime.parse(json["modifiedDate"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nickName": nickName,
    "epicUserId": epicUserId,
    "bankCode": bankCode,
    "ceftCode": ceftCode,
    "bankName": bankName,
    "accountNumber": accountNumber,
    "name": name,
    "favourite": favourite,
    "createdDate": createdDate!.toIso8601String(),
    "modifiedDate": modifiedDate!.toIso8601String(),
  };
}

