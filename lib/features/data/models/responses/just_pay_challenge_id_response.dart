// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final justPayChallengeIdResponse = justPayChallengeIdResponseFromJson(jsonString);

import 'dart:convert';

import '../common/base_response.dart';

JustPayChallengeIdResponse justPayChallengeIdResponseFromJson(String str) => JustPayChallengeIdResponse.fromJson(json.decode(str));

String justPayChallengeIdResponseToJson(JustPayChallengeIdResponse data) => json.encode(data.toJson());

class JustPayChallengeIdResponse extends Serializable {

  String? challengeId;
  JustPayChallengeIdResponse({
    this.challengeId,
  });



  factory JustPayChallengeIdResponse.fromJson(Map<String, dynamic> json) => JustPayChallengeIdResponse(
    
    challengeId: json["challengeId"],
  );

  @override
  Map<String, dynamic> toJson() => {

    "challengeId": challengeId,
  };



}
