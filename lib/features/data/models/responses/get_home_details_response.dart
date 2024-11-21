// To parse this JSON data, do
//
//     final getHomeDetailsResponse = getHomeDetailsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

GetHomeDetailsResponse getHomeDetailsResponseFromJson(String str) => GetHomeDetailsResponse.fromJson(json.decode(str));

String getHomeDetailsResponseToJson(GetHomeDetailsResponse data) => json.encode(data.toJson());

class GetHomeDetailsResponse extends Serializable {
  String callingName;
  String name;
  String userName;
  String mobileNumber;
  String email;

  GetHomeDetailsResponse({
    required this.callingName,
    required this.name,
    required this.userName,
    required this.mobileNumber,
    required this.email,
  });

  factory GetHomeDetailsResponse.fromJson(Map<String, dynamic> json) => GetHomeDetailsResponse(
        callingName: json["callingName"],
        name: json["name"],
        userName: json["userName"],
        mobileNumber: json["mobileNumber"],
        email: json["email"],
    );

  @override
  Map<String, dynamic> toJson() => {
    "callingName": callingName,
    "name": name,
    "userName": userName,
    "mobileNumber": mobileNumber,
    "email": email,
  };
}
