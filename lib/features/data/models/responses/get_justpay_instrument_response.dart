// import 'dart:convert';
//
// import '../common/base_response.dart';
//
//
// GetJustPayInstrumentResponse getJustPayInstrumentResponseFromJson(String str) =>
//     GetJustPayInstrumentResponse.fromJson(json.decode(str));
//
// String getJustPayInstrumentResponseToJson(GetJustPayInstrumentResponse data) =>
//     json.encode(data.toJson());
//
// class GetJustPayInstrumentResponse extends Serializable {
//   GetJustPayInstrumentResponse({
//     this.userInstrumentsList,
//   });
//   List<UserInstrumentsList>? userInstrumentsList;
//
//   factory GetJustPayInstrumentResponse.fromJson(Map<String, dynamic> json) =>
//       GetJustPayInstrumentResponse(
//         userInstrumentsList: json["userInstrumentsList"] == null
//             ? []
//             : List<UserInstrumentsList>.from(json["userInstrumentsList"]
//                 .map((x) => UserInstrumentsList.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "userInstrumentsList":
//             List<dynamic>.from(userInstrumentsList!.map((x) => x.toJson())),
//       };
// }
//
// class UserInstrumentsList {
//   int? id;
//   String? accountNo;
//   String? accType;
//   String? bankCode;
//   String? bankName;
//   String? nickName;
//   String? status;
//
//   UserInstrumentsList({
//      this.id,
//      this.accountNo,
//      this.accType,
//      this.bankCode,
//      this.bankName,
//      this.nickName,
//      this.status,
//   });
//
//   factory UserInstrumentsList.fromJson(Map<String, dynamic> json) =>
//       UserInstrumentsList(
//         id: json["id"],
//         accountNo: json["accountNo"],
//         accType: json["accType"],
//         bankCode: json["bankCode"],
//         bankName: json["bankName"],
//         nickName: json["nickName"],
//         status: json["status"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "accountNo": accountNo,
//         "accType": accType,
//         "bankCode": bankCode,
//         "bankName": bankName,
//         "nickName": nickName,
//         "status": status,
//       };
// }
// To parse this JSON data, do
//
//     final getJustPayInstrumentResponse = getJustPayInstrumentResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

GetJustPayInstrumentResponse getJustPayInstrumentResponseFromJson(String str) =>
    GetJustPayInstrumentResponse.fromJson(json.decode(str));

String getJustPayInstrumentResponseToJson(GetJustPayInstrumentResponse data) => json.encode(data.toJson());

class GetJustPayInstrumentResponse extends Serializable{
  List<UserInstrumentsList>? userInstrumentsList;

  GetJustPayInstrumentResponse({
     this.userInstrumentsList,
  });

  factory GetJustPayInstrumentResponse.fromJson(Map<String, dynamic> json) => GetJustPayInstrumentResponse(
    userInstrumentsList:json["userInstrumentsList"] == null
    ? []: List<UserInstrumentsList>.from(json["userInstrumentsList"].map((x) => UserInstrumentsList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "userInstrumentsList": List<dynamic>.from(userInstrumentsList!.map((x) => x.toJson())),
  };
}

class UserInstrumentsList {
  int? id;
  String? accountNo;
  String? accType;
  String? bankCode;
  String? bankName;
  String? nickName;
  String? status;

  UserInstrumentsList({
     this.id,
     this.accountNo,
     this.accType,
     this.bankCode,
     this.bankName,
     this.nickName,
     this.status,
  });

  factory UserInstrumentsList.fromJson(Map<String, dynamic> json) => UserInstrumentsList(
    id: json["id"],
    accountNo: json["accountNo"],
    accType: json["accType"],
    bankCode: json["bankCode"],
    bankName: json["bankName"],
    nickName: json["nickName"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "accountNo": accountNo,
    "accType": accType,
    "bankCode": bankCode,
    "bankName": bankName,
    "nickName": nickName,
    "status": status,
  };
}
