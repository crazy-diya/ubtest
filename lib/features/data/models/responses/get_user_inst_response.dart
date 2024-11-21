// To parse this JSON data, do
//
//     final getUserInstResponse = getUserInstResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

GetUserInstResponse getUserInstResponseFromJson(String str) =>
    GetUserInstResponse.fromJson(json.decode(str));

String getUserInstResponseToJson(GetUserInstResponse data) =>
    json.encode(data.toJson());

class GetUserInstResponse extends Serializable {
  GetUserInstResponse({
    this.userInstrumentsList,
  });

  List<UserInstruments>? userInstrumentsList;

  factory GetUserInstResponse.fromJson(Map<String, dynamic> json) =>
      GetUserInstResponse(
        userInstrumentsList: json["userInstrumentsList"] != null
            ? List<UserInstruments>.from(json["userInstrumentsList"]
                .map((x) => UserInstruments.fromJson(x)))
            : List.empty(),
      );

  Map<String, dynamic> toJson() => {
        "userInstrumentsList":
            List<dynamic>.from(userInstrumentsList!.map((x) => x.toJson())),
      };
}

class UserInstruments {
  UserInstruments({
    this.accountNo,
    this.accType,
    this.isPrimary,
    this.bankCode,
    this.bankName,
    this.nickName,
    this.alert,
    this.accountBalance,
    this.id,
    this.status,
    this.currency,
  });

  String? accountNo;
  int? id;
  String? accType;
  bool? isPrimary;
  String? bankCode;
  String? bankName;
  String? nickName;
  bool? alert;
  String? accountBalance;
  String? status;
  String? currency;

  factory UserInstruments.fromJson(Map<String, dynamic> json) =>
      UserInstruments(
        accountNo: json["accountNo"],
        id: json["id"],
        accType: json["accType"],
        isPrimary: json["isPrimary"],
        bankCode: json["bankCode"],
        bankName: json["bankName"],
        nickName: json["nickName"],
        alert: json["alert"],
        status: json["status"],
        accountBalance: json["accountBalance"],
        currency: json["currency"].toString().trim(),
      );

  Map<String, dynamic> toJson() => {
        "accountNo": accountNo,
        "id": id,
        "accType": accType,
        "isPrimary": isPrimary,
        "bankCode": bankCode,
        "bankName": bankName,
        "nickName": nickName,
        "alert": alert,
        "status": status,
        "accountBalance": accountBalance,
        "currency": currency,
      };
}
